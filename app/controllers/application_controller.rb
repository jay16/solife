class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from SyntaxError, :with => :deal_with_exceptions
  before_filter :record_traffic
  after_filter :flash_to_headers
  #:set_i18n_locale
  #before_filter :authenticate_user!


  #处理程序bug
  def deal_with_exceptions
    render template: "/exceptions/template", format: [:html], handler: [:erb], :layout => "/layout_v2/application"
  end

  #设置首页i18n多语言
  def set_i18n_locale
      session[:locale] = params[:locale] if params[:locale]
      I18n.locale = session[:locale] || I18n.default_locale
  end  

  def dd
    @options = {:coderay_line_numbers => :table,
      :coderay_bold_every => 10000,
      :coderay_css        => :class,
     }
  end
 
  #访客流量记录
  def record_traffic
    #monitor_controllers = %w(home segments)
    #reutrn unless monitor_controllers.include?(params[:controller])

    browser   = request.env["HTTP_USER_AGENT"]
    browser2  = request.user_agent
    remote_ip = request.remote_ip
    Traffic.create({
      :userid => session[:user_id],
      :url    => request.url,
      :controller => params[:controller],
      :action     => params[:action],
      :browser    => (browser.to_s.length > browser2.to_s.length ? browser : browser2),
      :ip         => remote_ip,
      :track_type => 1
     })
  end 

  def flash_to_headers
     return unless request.xhr?
     response.headers['X-Message'] = flash_message
     response.headers["X-Message-Type"] = flash_type.to_s

     flash.discard # don't want the flash to appear when you reload page
  end

  private

  def flash_message
     [:error, :warning, :notice, nil].each do |type|
       return "type is null" if type.nil?
       return flash[type] unless flash[type].blank?
     end
  end

  def flash_type
     [:error, :warning, :notice, nil].each do |type|
	 return "" if type.nil?
	 return type unless flash[type].blank?
     end
  end

end
