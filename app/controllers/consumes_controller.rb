#encoding: utf-8
class ConsumesController < ApplicationController
  
  before_filter :auth_user, except: [:index, :detail]
  before_filter :find_consume, only: [:show, :edit, :update, :destroy]
  before_filter :find_consume_type, only: [:new, :edit]

  layout "layout_v2/application"
  respond_to :html, :js

  def index
    user = (user_signed_in? ? current_user : User.find_by_email("jay_li@xsolife.com"))
    @consumes = user.consumes
      .select("day(consumes.created_at) as day, year(consumes.created_at) as year,month(consumes.created_at) as month,sum(volue) as sum_value")
      .group("year(consumes.created_at),month(consumes.created_at),day(consumes.created_at)")
      .order("year(consumes.created_at),month(consumes.created_at),day(consumes.created_at)")
  end

  def show; end
  
  def detail
    #%c 月，数值(0-12),%m 月，数值(00-12); 
    #%e 月的天，数值(0-31),%d 月的天，数值(00-31)

    user = (user_signed_in? ? current_user : User.find_by_email("jay_li@xsolife.com"))
    @consumes = user.consumes
      .where("date_format(consumes.created_at,'%Y%c%e')=#{params[:consume_date]}")
    @sum_value, @sum_msg, @sum_tags =0, "", []
    for consume in @consumes
      @sum_value += consume.volue
      @sum_msg += consume.msg+"\n"
      consume.tags.each do |tag|
	@sum_tags.push(tag)
      end if consume.tags
    end
    @sum_tags.uniq!
    @consume_at = @consumes.first.created_at

  end


  def new
    @consume = current_user.consumes.new

    respond_to do |format|
      format.html { render template: 'consumes/form', formats: [:html], handler: [:erb], locals: { consume: @consume } }
      format.js
    end
  end

  def create
    @consume = current_user.consumes.create(params[:consume])
    @consume.set_consume_type(params)
  end

  def edit; end

  def update
    #日期格式不匹配，则使用当前时间
    unless params[:consume][:created_at] =~ /\d+-\d+-\d+\s\d+:\d+:\d+/
      params[:consume][:created_at] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    end

    @consume.update_attributes(params[:consume])
    @consume.set_consume_type(params)
  end

  def destroy
    @consume.destroy
  end

  private

  def auth_user
    unless user_signed_in?
      flash[:alert] = "没有权限,请登陆"
      redirect_to :action => :index
    end
  end

  def find_consume
    @consume = current_user.consumes.find(params[:id])
  end

  def find_consume_type
    @taggroups = Taggroup.all
      .select { |d| d.type == "consume" }
      .sort { |a, b| a.label <=> b.label }
  end

end

