require 'resolv'
require 'net/smtp'

module SOLife 
  class ChkMail
    class << self

      def validate(exchange, from, to)
	begin
	  ret = Net::SMTP.start(exchange.to_s, 25) do |smtp|
	    smtp.mailfrom from
	    smtp.rcptto to
	  end
	rescue Net::SMTPAuthenticationError,
	  Net::SMTPServerBusy,
	  Net::SMTPSyntaxError,
	  Net::SMTPFatalError,
	  Net::SMTPUnknownError => error
	  fatal = error.message
	rescue IOError, TimeoutError, ArgumentError => error
	  fatal = error.message
	else
	  msg = ret.string
	end
        return [(msg.nil? ? false : true), (msg.nil? ? fatal : msg)]
      end

      def get_mx(domain)
        mx = []
	Resolv::DNS.open do |dns|
	  mx += dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
	end
        return mx.sort {|x,y| x.preference <=> y.preference}.flatten
      end

    end
  end
end
