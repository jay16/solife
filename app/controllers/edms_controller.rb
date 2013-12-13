class EdmsController < ApplicationController
  layout "layout_v2/application"

  before_filter :find_edm, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @edms = Edm.all
  end

  def new
    @edm = Edm.new
  end

  def create
    @edm = Edm.create(params[:edm])
  end

  def show;end

  def  deliver
    @edm = Edm.find(params[:edm_id])
    @edm.sendmail(params[:member_id])
  end

  def edit;end

  def update
    @edm.update_attributes(params[:edm])
  end

  def destroy
    @edm.destroy
  end
  
  def api_sendmail
    if params[:email] and params[:subject] and params[:content]
      render :text => Edm.first.api_sendmail(params[:email],params[:from],params[:subject],params[:content])
    else
      render :text => params.to_s
    end
  end

  private

  def find_edm
    @edm = Edm.find(params[:id])
  end


end
