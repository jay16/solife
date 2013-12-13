require './sntp.rb'

begin
  puts SOLife::SNTP.send_mail({subject: "dd",from: "527130673@qq.com", to: "jay_li@xsolife.com", content: "hello"})
rescue => e
  puts e.message
  puts e.backtrace
end
