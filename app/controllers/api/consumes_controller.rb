#encoding: utf-8
class Api::ConsumesController < ApplicationController
  
  def create
    ret, ret_info, consume = 0, "", {}
    params.delete_if { |p| %w(action controller).include?(p) }
    
    if params.empty?
      ret_info = "params is empty"
    else
      consume = User.find_by_email("android_app@solife.us")
        .consumes.create(params[:consume]) 

      if consume.save
        ret, ret_info, consume = 1, "OK", consume.to_json
      else
        ret, ret_info = 0, consume.errors.full_messages
      end
    end

    render :json => { :ret => ret, :ret_info => ret_info, :consume => consume}
  end

  def list
    ret_json_array = []
    user = User.find_by_email("android_app@solife.us")
    user.consumes.each do |c|
      ret_json_array.push({
        :user_id    => user.id,
	:consume_id => c.id,
	:msg  => c.msg,
	:volue => c.volue,
	:created_at => c.created_at.strftime("%Y-%m-%d %H:%M:%S"),
	:updated_at => c.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      })
    end

    render :json => ret_json_array.to_json
  end
end

