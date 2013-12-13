module ToolsMailerHelper
  
  def domain_group(mails)
    emails  = Array.new
    domains = Array.new
    
    mails.each do |mail|
      domains.push(mail.login_name.split("@")[1].chomp)
      emails.push(mail.login_name)
    end
    
    return domains.uniq,emails.uniq
  end
  
  def email_group(emails,domain)
    array = Array.new
    
    emails.each do |email|
      array.push(email) if email.login_name.split("@")[1] == domain
    end
    
    return array.uniq
  end
  
  def inbox
    
  end
end
