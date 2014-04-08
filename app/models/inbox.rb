class Inbox < ActiveRecord::Base
  attr_accessible :mail_body, :mail_cc, :mail_date, :mail_from, :mail_message_id, :mail_orgstr, :mail_sender, :mail_subject, :mail_to, :maillist_id, :inbox_type
  belongs_to :maillist
end
