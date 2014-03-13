#encoding: utf-8
require "digest/sha2"

namespace :chk do 

  desc "email&password验证api token"
  task :api_token => :environment do 
      email = "jay_li@solife.us"
	  pwd   = "jay527130673"
	  User.all.each do |user|
	      next unless user
		  puts user.encrypted_password
		  #puts user.id.to_s + "-" + user.email.to_s + "-" + user.hashed_password.to_s
		  puts Digest::MD5.hexdigest(pwd)
      end
  end

end
