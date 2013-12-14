# This file is used by Rack-based servers to start the application.
current_dir = Dir.pwd
system("chown -R webuser:webuser #{current_dir}")

require ::File.expand_path('../config/environment',  __FILE__)
run Solife::Application
