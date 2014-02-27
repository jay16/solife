#encoding: utf-8
class Api::ConsumesController < ApplicationController
  before_filter :authen_user
  
  def create
    ret, ret_info, consume = 0, "", {}
    consume = @user.consumes.create(params[:consume]) 

    if consume.save
      ConsumeTag.create({:consume_id => consume.id, :tag_id => 119})
      ret, ret_info, consume = 1, "OK", consume.to_json
    else
      ret, ret_info = 0, consume.errors.full_messages
    end

    render :json => { :ret => ret, :ret_info => ret_info, :consume => consume}
  end

  def list
    ret_json_array = []
    Consume.all.each do |c|
      ret_json_array.push({
        :user_id    => c.users.first.id,
	:consume_id => c.id,
	:msg        => c.msg,
	:volue      => c.volue,
	:created_at => c.created_at.strftime("%Y-%m-%d %H:%M:%S"),
	:updated_at => c.updated_at.strftime("%Y-%m-%d %H:%M:%S"),
	:sync => 1
      })
    end

    render :json => ret_json_array.to_json
  end

  def update
    ret, ret_info = 0, ""
    if consume = Consume.find(params[:id])
      if consume.update_attributes(params[:consume])
        ret, ret_info = 1, "successfully"
      else
        ret, ret_info = 0, "update fail"
      end
    else
      ret, ret_info = 0, "not found consume"
    end
  end

  def delete
  end

  private

  def authen_user
    unless @user = User.find_by_email(params[:email]) 
      render :json => { :ret => 0, :ret_info => "authen user fail" } 
    end
  end
end

