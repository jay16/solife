#encoding: utf-8
class Api::UsersController < ApplicationController
  
  def login
    ret, ret_info, user_name, user_area, user_gravatar,user_register = 0, "", "", "", "",""
    
    if params[:email]
      if user = User.find_by_email(params[:email])
        ret, ret_info =  1, "OK" 
	user_name = user.name
	user_gravatar = gravatar_image_tag(params[:email])
	user_register = user.created_at.strftime("%Y-%m-%d %H:%M")
      else
        ret, ret_info = 0, "user not exist"
      end
    else
      ret, ret_info = 0, "params is empty"
    end

    render :json => { 
      :ret => ret, 
      :ret_info => ret_info, 
      :user_name => user_name, 
      :user_email => params[:email], 
      :user_province => "上海" }
  end

end

