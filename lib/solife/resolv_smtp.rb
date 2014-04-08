#使用resolv与smtp发信
#!/usr/local/bin/ruby -w
require 'resolv'
require 'net/smtp'

from = "solife_li@sina.com"
tos = ["jay_li@xsolife.com","jay_li@intfocus.com"]

tos.each do |to|
  message = "
  From: #{from}
  To: #{to}
  Subject: Direct e-mail test
  This is a test e-mail message.
  "


  to_domain = to.match(/\@(.+)/)[1]

  Resolv::DNS.open do |dns|
    mail_servers = dns.getresources(to_domain, Resolv::DNS::Resource::IN::MX)
    mail_server = mail_servers[rand(mail_servers.size)].exchange.to_s

    Net::SMTP.start(mail_server) do |smtp|
      smtp.send_message message, from, to
    end
  end
end
