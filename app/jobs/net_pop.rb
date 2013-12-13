require 'mail'
require 'net/pop'

class NetPOP
  
  #从服务器收信  
  def self.net_pop(mail)
    begin
          Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
    pop = Net::POP3.start(mail.email_pop, mail.pop_port,mail.login_name, mail.email_pwd)
    rescue => e
      fail = { 
        :is_valid => false,
        :unvalid  => e.to_s
        }
      mail.update_attributes(fail)
      
      return false
    else
      if pop.mails.empty?
        puts 'No mail.'
      else
        inbox    = pop.mails
        mail_num = inbox.size
        
        #收件箱邮件数量=邮件服务器中邮件数量时
        #为未有新邮件
        return false  if mail.sign_index == mail_num
        
        unread = inbox[mail.sign_index..mail_num-1]
      
        #若收件箱数组没有each_with_index方法，
        #可放弃读取
        return false unless unread.respond_to?(:each_with_index)
        begin
          unread.each_with_index do |m,index|   # or pop.each_mail
            puts "inbox :"+index.to_s
            inbox = {
              :mail_orgstr     => m.pop.to_s,
              :inbox_type => 1,
            }
            
            mail.inboxes.create(inbox).save
            #m.delete
          end
        rescue => ee
          puts "ERROR:unread.each_with_index :" + ee.to_s
          return false
        else
           #sign_index标记为mail_num，下次从mail_num坐标起
          #读取新邮件
          mail.update_attribute(:sign_index,mail_num)
          puts "MAIL POPED:#{pop.mails.size}"
        end
        
      end
      
      return true
    end
  end
  
  #解析邮件内容
  def self.mail_parser(mail)
    unparsers = mail.inboxes.where("mail_from is null and mail_orgstr is not null")
    unparsers.each_with_index do |inbox,index|
      puts "parser inbox:" + index.to_s
      begin
        parser = Mail.new(inbox.mail_orgstr)
      rescue => e
        puts "PARSER ERROR:" + e.to_s
      else
        hash = {
          :mail_date    => parser.date.to_s,
          :mail_from    => parser.from.to_s,
          :mail_sender  => parser.sender.to_s,
          :mail_to      => parser.to.to_s,
          :mail_cc      => parser.cc.to_s,
          :mail_subject => parser.subject.to_s,
          :mail_body    => parser.body.decoded.to_s,
          :inbox_type   => 1,
          :mail_message_id => parser.message_id.to_s
        }
        inbox.update_attributes(hash)
      end
    end
  end
  
end
