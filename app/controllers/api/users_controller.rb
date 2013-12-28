#encoding: utf-8
class Api::UsersController < ApplicationController
  
  def login
    ret, ret_info, consume = 0, "", {}
    
    if params[:email]
      if User.find_by_email(params[:email])
        ret, ret_info = 1, "OK"
      else
        ret, ret_info = 0, "user not exist"
      end
    else
      ret, ret_info = 0, "params is empty"
    end

    render :json => { :ret => ret, :ret_info => ret_info}
  end

end

