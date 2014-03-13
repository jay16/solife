#encoding: utf-8
require 'bcrypt'
require "digest/sha2"

namespace :chk do 

  desc "email&password验证api token"
  task :api_token => :environment do 
      email = "jay_li@solife.us"
	  pwd   = "jay527130673"
	  user = User.find_by_email(email)
	  puts user.id.to_s + "-" + user.email.to_s + "-" + user.encrypted_password
	  #puts Digest::MD5.hexdigest(str).upcase
	  puts user.valid_password?(pwd)
      puts valid_password?(pwd, user.encrypted_password)
  end

  # Verifies whether an password (ie from sign in) is the user password.
  def valid_password?(password, encrypted_password)
	return false if encrypted_password.blank?
	bcrypt   = ::BCrypt::Password.new(encrypted_password)
	password = ::BCrypt::Engine.hash_secret("#{password}#{SecureRandom.hex(64)}", bcrypt.salt)
	puts password
	puts encrypted_password
	secure_compare(password, encrypted_password)
  end  

  # constant-time comparison algorithm to prevent timing attacks
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
	puts res
    res == 0
  end

   task :api_token2 => :environment do
     email = "jay_li@solife.us"
     pwd   = "jay527130673"
     user = User.find_by_email(email)
     puts user.id.to_s + "-" + user.email.to_s + "-" + user.encrypted_password
     #puts Digest::MD5.hexdigest(str).upcase
     #puts user.valid_password?(pwd)

     bcrypt   = ::BCrypt::Password.new(user.encrypted_password)
     password = ::BCrypt::Engine.hash_secret("#{pwd}#{SecureRandom.hex(64)}", bcrypt.salt)
     puts password
	 puts user.encrypted_password.bytesize
	 puts password.bytesize
     a = bcrypt
     b = password 
     l = a.unpack "C#{a.bytesize}"
     res = 0 
     user.encrypted_password.each_byte { |byte| res |= byte ^ l.shift }
     puts res
   end
end
