#encoding: utf-8
require "fileutils"
require 'qiniu-rs'

#===============================================

#数据库备份位置
db_bak_path = "/home/work/solife/db/db.bak"
raise "db_bak_path:#{db_bak_path}" unless File.exist?(db_bak_path)

#===============================================
#七牛配置信息
AK = "gPQo6zcUBMtLdXGWl2A3VK-zchb2LXzZhfWtWsou"
SK = "whGyzlD1xwaT4VbyEQ81B51ROWqIPTSlI4iXeY1-"
bucket_name = "solife-db"

#七牛api连接
Qiniu::RS.establish_connection!({ :access_key => AK, :secret_key => SK })

#七牛上传文件
def qiniu_upload(bucket_name, backup_file)
  tmp_token = Qiniu::RS.generate_upload_token({
   :scope => bucket_name,
   :expires_in => 36000
  })

  Qiniu::RS.upload_file({
    :uptoken => tmp_token,
    :file => backup_file,
    :bucket => bucket_name,
    :key => File.basename(backup_file)
  })
end

#检测七牛服务器上是否存在
#不存在则上传
def qiniu_cmd(bucket_name, backup_file, cmd, force = false)
  key = File.basename(backup_file)
  #查看文件信息
  is_exist = Qiniu::RS.stat(bucket_name, key)

  if is_exist and cmd == "delete"
    Qiniu::RS.delete(bucket_name, key)
  elsif !is_exist and cmd == "upload"
    qiniu_upload(bucket_name, backup_file)
  elsif is_exist and cmd == "upload" and force
    Qiniu::RS.delete(bucket_name, key)
    qiniu_upload(bucket_name, backup_file)
  end
end

def days_ago(num)
  now_i = Time.now.to_i
  ago_i = now_i - num*24*60*60
  Time.at(ago_i).strftime("%Y%m%d")
end

def bak_file_name(timestamp)
  "solife.db.bak.at.#{timestamp}.tar.gz"
end

#===============================================

today_bak_file = bak_file_name(days_ago(0))

#生成shell脚本，备份数据库
shell_content =<<SHELL
  cd #{db_bak_path}                                      \n
  mysqldump -uroot -pFocus_01 solife > solife.db.bak.sql \n
  tar -czvf #{today_bak_file} solife.db.bak.sql          \n
  rm -f solife.db.bak.sql                                \n
SHELL

#执行shell脚本
puts system("#{shell_content}")

today_bak_path = File.join(db_bak_path,today_bak_file)

#备份今天的数据库失败，则终止后续操作
raise "bak today's database fails!" unless File.exists?(today_bak_path)

#===============================================

#所有solife数据库备份
#清除30天以外的备份
wait_delete_files = Dir.entries(db_bak_path).select{ |f| f.index("solife") }

#qiniuh上传今天的数据备份
#不存在则上传，存在则删除后再上传
qiniu_cmd(bucket_name,today_bak_path,"upload", true)

#清除30天以外的备份
wait_delete_files.delete(today_bak_file)
#保存30天的数据库备份
(1..30).each do |num|
  timestamp = days_ago(num)
  db_bak_file = bak_file_name(timestamp)
  bak_file_path  = File.join(db_bak_path,db_bak_file)

  if File.exists?(bak_file_path)
    puts "#{num}-ok" 
    #qiniuh检测历史备份是否存在
    #不存在则上传，存在则不做任何动作
    qiniu_cmd(bucket_name,bak_file_path,"upload")
    #清除30天以外的备份
    wait_delete_files.delete(db_bak_file)
  else
    puts "not exist:#{db_bak_file}"
  end
end

#===============================================

#删除30天以外的备份
unless wait_delete_files.empty?
  wait_delete_paths = wait_delete_files.map{ |f| File.join(db_bak_path,f) }
  FileUtils.rm_f(wait_delete_paths) 
  wait_delete_paths.each do |backup_file|
    qiniu_cmd(bucket_name, backup_file, "delete")
  end
end
