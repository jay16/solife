class Maillist < ActiveRecord::Base
  attr_accessible :domain, :email_name, :email_pop, :email_pwd, :email_smtp, :login_name, :mail_id, :pop_port, :smtp_port, :is_valid, :unvalid, :sign_index
  belongs_to :mailer
  has_many :inboxes
end
