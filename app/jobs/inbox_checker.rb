class Inbox_Checker
  @queue = "inbox_checker"
  
  def self.perform(email)
     mail = Maillist.where("login_name='#{email}'").first()

     NetPOP::mail_parser(mail) if NetPOP::net_pop(mail)
     
  end
  
end
