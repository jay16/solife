=begin
require 'mail'
require 'net/pop'
#require 'resque'
class ToolsMailerController < ApplicationController
  def index
    mailer = params[:mailer]
    
    @mails = Mailer.where("name=#{mailer}").first()
               .maillists.where("is_valid = true")
  end

  #显示指定邮箱的收件箱
  def show
    email = params[:email]
    @mail = Maillist.where("login_name='#{email}'").first
  end

  def check_inbox
  end
  
  #添加新邮箱
  def new
  end
  def mail_create
    mail = {
      :domain     => params[:email].split("@")[1],
      :email_name => params[:email],
      :email_pop  => params[:pop],
      :email_pwd  => params[:pwd],
      :email_smtp => params[:smtp],
      :login_name => params[:email],
      :pop_port   => params[:pport],
      :smtp_port  => params[:sport],
      :is_valid   => true,
      :sign_index => 0
    }
    if Maillist.where("login_name='#{params[:email]}'").count >= 1 then 
      @rt = 1
    elsif  Maillist.create(mail).save
      @rt = 2
    else
      @rt = 3
    end
    
    render :text => @rt
  end
  
  def edit
    @mail = Maillist.where("login_name='#{params[:email]}'").first()
  end

  def update
    mail = {
      :domain     => params[:email].split("@")[1],
      :email_name => params[:email],
      :email_pop  => params[:pop],
      :email_pwd  => params[:pwd],
      :email_smtp => params[:smtp],
      :login_name => params[:email],
      :pop_port   => params[:pport],
      :smtp_port  => params[:sport],
      :is_valid   => true,
      :sign_index => 0
    }
    mails = Maillist.where("email_name='#{params[:email]}'")
    if mails.count >= 1 then 
      @rt = 1
      @rt = 2 if mails.first().update_attributes(mail)
    else
      @rt = 3
    end
    
  end

  def destroy
  end
 
  #查看指定邮箱的收件箱
  def mail_checker
    email = params[:email]
    
    if email and email.split("@").length == 2 then
      Resque.enqueue(Inbox_Checker,email)
      
      render :text => "Check #{email} Inbox..."
    else
      render :text => "InCorrect Email: #{email}"
    end
  end
  
  #查收所有有效邮箱的收件箱
  def mail_guarder
    Resque.enqueue(Inbox_Guarder)
    render :text => "resque is running"
  end
  
  def pop
    mail = Maillist.where("login_name='ed_eli@163.com'").first
    #net_pop(mail)
    mail_parser(mail)
    
    render :text => "inbox over"
  end

  def smtp
  end
  

  def mail
    Mail.defaults do
      retriever_method :pop3,
              :address    => mail.email_pop,
              :port       => mail.pop_port,
              :user_name  => mail.login_name,
              :password   => mail.email_pwd,
              :enable_ssl => true
    end
      
    inboxes = Mail.all
    render :text => inboxes[0].to_s
  end
  
  
end

# select distinct right(login_name,length(login_name)-locate("@",login_name)+1) from maillists;
=end
