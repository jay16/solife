#encoding: utf-8
class Api::ConsumesController < ApplicationController
  
  def create
    render :json => params.to_json
  end

  def list
    render :json => params.to_json
  end
end

