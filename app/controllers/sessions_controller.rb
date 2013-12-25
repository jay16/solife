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
    flash[:alert] = "您已成功登陆SOLife"
  end

  #退出后刷新当前界面
  def destroy
    #super
    reset_session
    flash[:alert] = "您已成功退出SOLife"
  end
end
