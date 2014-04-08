#!/usr/bin/env ruby
require 'qiniu-rs'

raise "don't run..."

AK = "gPQo6zcUBMtLdXGWl2A3VK-zchb2LXzZhfWtWsou"
SK = "whGyzlD1xwaT4VbyEQ81B51ROWqIPTSlI4iXeY1-"
bucket_name = "solife"
backup_file = "/home/work/solife/db/db.bak/solife.db.bak.at.20131123.tar.gz"

Qiniu::RS.establish_connection!({ :access_key => AK, :secret_key => SK })
 
 
token = Qiniu::RS.generate_upload_token({
 :scope => bucket_name,
 :expires_in => 3600
# :callback_url => callback_url,
# :callback_body => callback_body,
# :callback_body_type => callback_body_type,
# :customer => end_user_id,
# :escape => allow_upload_callback_api,
# :async_options => async_callback_api_commands,
# :return_body => custom_response_body
})
 
puts token
 
ret = Qiniu::RS.upload_file({ 
  :uptoken => token,
  :file => backup_file,
  :bucket => bucket_name,
  :key => File.basename(backup_file)
})
 
 
puts ret

#查看文件信息
puts Qiniu::RS.stat(bucket_name, key)

#复制文件
target_bucket = "solife-db"
target_key = key
#Qiniu::RS.copy(bucket_name, key, target_bucket, target_key)
#puts Qiniu::RS.delete(target_bucket, target_key)
#puts Qiniu::RS.move(bucket_name, key, target_bucket, target_key)

#Qiniu::RS.batch(command, bucket, keys)
