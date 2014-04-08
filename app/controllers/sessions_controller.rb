#encoding: utf-8
class SessionsController < Devise::SessionsController
  layout "layout_v2/application"
  respond_to :html, :js

  #before_filter :reset_devise_session, only: [:create]
  #自定义devise登陆界面
  def new
    super
  end

  #登陆后刷新当前界面
  def create
    super
  end

  #退出后刷新当前界面
  def destroy
    reset_session
  end

  private

  def reset_devise_session
    #已登陆状态，切换账户时
    #还处于登陆状态
    request.reset_session if user_signed_in?
  end
end
