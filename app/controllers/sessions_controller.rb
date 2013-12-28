#encoding: utf-8
class SessionsController < Devise::SessionsController
  layout "layout_v2/application"
  respond_to :html, :js

  #自定义devise登陆界面
  def new
    super
  end

  #登陆后刷新当前界面
  def create
    super
    #self.resource = warden.authenticate!(auth_options)
    #set_flash_message(:notice, :signed_in) if is_flashing_format?
    #sign_in(resource_name, resource)
    #yield resource if block_given?

    flash[:alert] = "您已成功登陆SOLife"
    #redirect_to request.path
  end

  #退出后刷新当前界面
  def destroy
    #super
    reset_session
    flash[:alert] = "您已成功退出SOLife"
  end
end
