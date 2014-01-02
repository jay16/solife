#encoding: utf-8
class Api::UsersController < ApplicationController
  
  def login
    ret, ret_info, user_name = 0, "", ""
    
    if params[:email]
      if user = User.find_by_email(params[:email])
        ret, ret_info, user_name = 1, "OK", user.name
      else
        ret, ret_info = 0, "user not exist"
      end
    else
      ret, ret_info = 0, "params is empty"
    end

    render :json => { :ret => ret, :ret_info => ret_info, :user_name => user_name, :user_email => params[:email], :user_province => "上海" }
  end

end

