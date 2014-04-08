#encoding: utf-8
require "ip_reverse"
class Api::UsersController < ApplicationController
delegate "gravatar_image_url", :to => "ActionController::Base.helpers"
  
  #验证用户信息
  #若正确，返回用户相关信息
  def validate
    ret, ret_info  = 0, ""
    user_id, user_name, user_area, user_gravatar,user_register = -1, "unname", "unarea", "ungravatar", "untime"
    
    if params[:email]
      if user = User.find_by_email(params[:email])
        ret, ret_info =  1, "OK" 
	user_name     = user.name
	user_id       = user.id
	user_gravatar = gravatar_image_url(params[:email])
        user_register = user.created_at.strftime("%Y-%m-%d %H:%M") #"2013-06-07 07:12"
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
      :user_id    => user_id,
      :user_name  => user_name, 
      :user_email => params[:email], 
      :user_register => user_register,
      :user_province => user_area,
      :user_gravatar => user_gravatar
    }
  end

  def info
    if user = User.find(params[:id])
      render :json => {
        :ret => 1,
	:ret_info => "YES",
        :id => user.id,
	:name => user.name,
	:email => user.email,
	:created_at => user.created_at.strftime("%Y-%m-%d %H:%M"),
	:updated_at => user.updated_at.strftime("%Y-%m-%d %H:%M")
      }
    else
      render :json => {
        :ret => -1,
	:ret_info => "user not exist"
      }
    end
  end

end

