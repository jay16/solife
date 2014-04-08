#encoding: utf-8
require 'sntp'
require 'mail'
class Edm < ActiveRecord::Base
  attr_accessible :from, :from_email, :name, :subject
  attr_accessible :template_id
  validates :subject, presence: true, uniqueness: true

  has_many :edm_logs


  #发信动作
  def sendmail(id)
      member = Member.find(id)
      from = member.from
      pfrom = from
      to = member.email
      ret = "OK"
      start = Time.now

      begin
        content = Segment.find(template_id).title
        ret = SOLife::SNTP.send_mail({
                exchange: member.best_mx.exchange, 
		from: from, 
		to: to, 
		content: mail_body(pfrom,to,self.subject,content)
        })
      rescue => e
        ret = e.message 
      ensure
        duration = Time.now.to_i - start.to_i
	EdmLog.create({
	  :edm_id => self.id,
	  :begin => start,
	  :duration => duration,
	  :subject => self.subject,
	  :frem => from,
	  :tu => to,
	  :method => "smtp",
	  :statu => ret
        })
      end
  end

  def mail_body(from,to,subject,content)
    Mail.new({
      :date => Time.now,
      :to => to,
      :from => from,
      :subject => subject,
      :content_type => 'text/html; charset=UTF-8',
      :content_id => '<' + Time.now().to_f.to_s + '@' + Time.now().to_f.to_s.split(".")[1] + '.com>',
      :content_transfer_encoding => 'base64',
      :body => Base64.encode64(content)
    }).to_s
  end

  #api发信动作
  def api_sendmail(email,pfrom,subject,content)
      member = Member.find_or_create_by_email(email)
      from = member.from
      pfrom ||= from
      to = member.email
      ret = "OK"

      start = Time.now
      begin
        ret = SOLife::SNTP.send_mail({
                exchange: member.best_mx.exchange, 
		from: from, 
		to: to, 
		content: mail_body(pfrom,to,subject,content)
        })
      rescue => e
        ret = e.message 
      ensure
        duration = Time.now.to_i - start.to_i
	EdmLog.create({
	  :edm_id => -1,
	  :begin => start,
	  :duration => duration,
	  :subject => subject,
	  :frem => from,
	  :tu => to,
	  :method => "api smtp",
	  :statu => ret
        })

      end
     return ret
  end
end

=begin
    message = "Date: #{Time.now.strftime('%a, %d %b %Y %H:%M:%S %z')}\r\n"
    message << "From: #{from}\r\n"
    message << "To: #{to}\r\n"
    message << "Message-ID: <#{Time.now().to_f.to_s}@#{Time.now().to_f.to_s.split('.')[1]}.com>\r\n"
    message << "Subject: #{subject}\r\n"
    message << "Mime-Version: 1.0\r\n"
    message << "Content-Type: text/plain;\r\n"
    message << " charset=UTF-8\r\n"
    message << "Content-Transfer-Encoding: 7bit\r\n"
    message << "\r\n"
    message << "#{content}"
=end
