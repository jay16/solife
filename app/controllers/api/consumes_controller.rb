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
    consumes = User.find_by_email("android_app@solife.us").consumes
    render :json => consumes.to_json
  end
end

