#encoding: utf-8
class EdmLogsController < ApplicationController
  layout false

  before_filter :find_edm, only: [:index, :show, :new, :create, :edit, :update]
  before_filter :find_edm_log, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  #响应edms列表查看log
  def index
    if @edm and @edm.edm_logs
      @edm_logs = @edm.edm_logs.order("created_at desc") 
    else
      @edm_logs = EdmLog.order("created_at desc") 
    end
  end

  def show; end

  def new
    @edm_log = @edm.edm_logs.new
  end

  def create
    @edm_log = @edm.edm_logs.create(params[:edm_log])
  end

  def edit; end

  def update
    @edm_log.update_attributes(params[:edm_log])
  end

  def destroy
    @edm_log.destroy
  end

  private

  def find_edm
    @edm = params[:edm_id] ? Edm.find(params[:edm_id]) : nil
  end

  def find_edm_log
    @edm_log = EdmLog.find(params[:id])
  end

end

