class Inbox_Guarder
  @queue = "inbox_guarder"
  
  def self.perform
     Maillist.where("is_valid=1").each_with_index do |mail,index|
       puts "Mail List:" + index.to_s
       
       NetPOP::mail_parser(mail) if NetPOP::net_pop(mail)
     end
     
  end
  
end
