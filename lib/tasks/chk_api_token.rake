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
    pepper = "39dd46bfe0dee2d2f5b98862b6b8bf24b736ee877efd5df95f48cf6ca5310b72d267f216d6138684de626297f2927ed7e99106058013e5d66d0b8ff3af8a234a"
	password1 = ::BCrypt::Engine.hash_secret("#{password}#{pepper}", bcrypt.salt)
	puts password1
	password = ::BCrypt::Engine.hash_secret("#{password}#{SecureRandom.hex(64)}", bcrypt.salt)
	puts password
	puts encrypted_password
	str = [password, nil].flatten.compact.join
	secure_compare(Digest::MD5.hexdigest(str), encrypted_password)
  end  

  # constant-time comparison algorithm to prevent timing attacks
  def secure_compare(a, b)
    return false if a.blank? || b.blank? || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"
	puts l.class

    res = 0
    b.each_byte do |byte| 
	  k = l.shift
	  res |= byte ^ k
	  puts "#{byte}-#{k}-#{res}"
	end
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
     a = password
     b = user.encrypted_password
     l = a.unpack "C#{a.bytesize}"
     res = 0 
     user.encrypted_password.each_byte { |byte| res |= byte ^ l.shift }
     puts res
   end
end
