#encoding: utf-8
require 'mail'
require 'base64'
require 'net/smtp'

module SOLife
  #避免与SMPT重名
  class SNTP
    attr_accessor :settings
    class << self

       def send_mail(values={})
	 @settings = { 
	   :address              => "localhost",
	   :port                 => 25,
	   :domain               => 'localhost.localdomain',
	   :user_name            => nil,
	   :password             => nil,
	   :authentication       => nil,
	   :enable_starttls_auto => true,
	   :openssl_verify_mode  => nil,
	   :ssl                  => nil,
	   :tls                  => nil,
           :res                  => nil
	 }.merge!(values)
	
         if @settings[:exchange] 
	   chk_params("exchange")
	   Net::SMTP.start(@settings[:exchange]) do |smtp|
	     smtp.send_message(@settings[:content], @settings[:from], @settings[:to]).string
	   end
         else
	   chk_params("default")
	   smtp = Net::SMTP.new(@settings[:address], @settings[:port])
	   smtp.start(@settings[:domain], @settings[:user_name], @settings[:password], @settings[:authentication]) do |obj|
	     obj.send_message(@settings[:content], @settings[:from], @settings[:to]).string
	   end
         end
       end

       def chk_params(type)
	 unless @settings[:content] and @settings[:from] and @settings[:to]
	   raise "from => to | content not take all!"
	 end
	 if type == "exchange"
	   raise "deliver with exchange, but exchange not take all!" unless @settings[:exchange]
	 end
       end

    end
  end
end
