#encoding: utf-8
require "ip_reverse"

namespace :solife do 

  desc "deal with git"
  namespace :git do

    desc "push files to githtup"
    task :push do
      timestamp = Time.now.strftime("%Y/%m/%d-%H:%M:%S")

      shell_content =<<SHELL
	git_path=$(which git)
	cd /home/work/solife
	${git_path} init
	${git_path} add -A .
	${git_path} commit -a -m "auto commit - #{timestamp}"
	${git_path} push origin master -f
SHELL
      system(shell_content)
    end

  end

  desc "同步traffic访客ip至ip_map"
  namespace :ip_map do 

    desc "traffic ip,count先存储至ip_map"
    task :update_count => :environment do 
      infos = Traffic.select("ip,count(*) as ip_count").group("ip")
      for info in infos
        ip_map = IpMap.find_or_create_by_ip(info.ip)
	ip_map.update_attribute(:count, info.ip_count)
      end
    end

    desc "解析ip所属省份"
    task :ip_reverse => :environment do
      IpMap.where("ret is null").each do |ip_map|
	ip_reverse = IpReverse.reverse(ip_map.ip)
	puts ip_map.ip + ip_reverse.to_s
	if ip_reverse['result'] == "success"
	  ip_map.update_attributes({
	    :ret => ip_reverse['result'],
	    :country => ip_reverse['country'],
	    :province => ip_reverse['province'],
	    :city => ip_reverse['city'],
	    :county => ip_reverse['county'],
	    :isp => ip_reverse['isp'],
	    :area => ip_reverse['area']
	  })
	else
	  ip_map.update_attributes({
	    :ret => ip_reverse['result'],
	    :message => ip_reverse['message']
	  })
	end
      end
    end
  end

  desc "更新数据库表traffic字段province"
  namespace :traffic do
    desc "解析ip所属省份"    
    task :ip_reverse => :environment do
      traffic = Traffic.where("province is null").each do |traffic|
	ip_reverse = IpReverse.reverse(traffic.ip)
	puts traffic.ip + ip_reverse['result']
	if ip_reverse['result'] == "success"
	  province = ip_reverse['province']
	  puts province
	  traffic.update_attribute(:province, province)
	else
	  puts ip_reverse['message']
	end
      end
    end
  end

end
