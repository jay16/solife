# This file is used by Rack-based servers to start the application.

#启动时遍历当前文件夹修改文件用户组
#避免nginx无权限读取文件
current_dir = Dir.pwd
system("chown -R webuser:webuser #{current_dir}")

require ::File.expand_path('../config/environment',  __FILE__)
run Solife::Application
