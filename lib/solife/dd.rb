require './chk_mail.rb'

mx= SOLife::ChkMail.get_mx("jay_li@xsolife.com")
puts mx.to_s
puts mx.inspect

puts SOLife::ChkMail.validate(mx.first.exchange.to_s,"527130673@qq.com","jay_li@xsolife.com")

