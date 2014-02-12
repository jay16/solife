#encoding: utf-8
require "ip_reverse"
class Api::UsersController < ApplicationController
delegate "gravatar_image_tag", :to => "ActionController::Base.helpers"
  
  def info
    ret, ret_info, user_name, user_area, user_gravatar,user_register = 0, "", "", "读取失败", "",""
    
    if params[:email]
      if user = User.find_by_email(params[:email])
        ret, ret_info =  1, "OK" 
	user_name = user.name
	user_gravatar = gravatar_image_tag(params[:email])
        user_register = "2013-06-07 07:12"
	ip_reverse = IpReverse.reverse(request.remote_ip)
	if ip_reverse['result'] == "success"
          user_area = ip_reverse['country']+ip_reverse['province']
        end
      else
        ret, ret_info = 0, "用户不存在"
      end
    else
      ret, ret_info = 0, "参数为空"
    end

    render :json => { 
      :ret        => ret, 
      :ret_info   => ret_info, 
      :user_name  => user_name, 
      :user_email => params[:email], 
      :user_register => user_register,
      :user_province => user_area,
      :user_gravatar => user_gravatar
    }
  end

end

