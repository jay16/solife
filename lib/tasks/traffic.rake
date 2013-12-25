#encoding: utf-8
require "ip_reverse"

namespace :traffic do 


  desc "traffic ip,count先存储至ip_map"
  task :update_count => :environment do 
    puts "traffic ip,count先存储至ip_map"
    infos = Traffic.select("ip,count(*) as ip_count").group("ip")
    for info in infos
      ip_map = IpMap.find_or_create_by_ip(info.ip)
      ip_map.update_attribute(:count, info.ip_count)
    end
  end

  desc "解析ip所属省份"
  task :ip_reverse => :environment do
    puts "先更新count"
    Rake::Task["solife:ip_map:update_count"].invoke

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
