#encoding: utf-8
class MxesController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
    @mxes = Mx.order("updated_at desc")
  end

  def show
    @mx = Mx.find(params[:id])
  end

  def new
    @mx = Mx.new
  end

  def create
    @mx = Mx.create(params[:mx])
  end

  def edit
  end

  def update
    @mx = Mx.find(params[:id])
    if @mx.update(params[:mx])
      redirect_to(@mx)
    else
      render "edit"
    end
  end

  def destroy
  end

end

