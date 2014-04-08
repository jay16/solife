class OpenController <  ActionController::Base 

  def mailer
    email    = params[:email]
    tar_name = params[:tar_name]
    md5      = params[:md5]
    strftime = params[:stftime]
    
    FocusApi::Mailer.deliver(email,tar_name,md5,strftime)
    puts "*"*10
    puts params.to_s
    if email && tar_name && md5 && strftime then
      render :json => { :code => 1, :info => "data is detail!" }
    else
      render :json => { :code => 0, :info => "#{params.to_s}" }
    end 
  end  
end

