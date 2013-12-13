#encoding: utf-8
class ConsumesController < ApplicationController
  layout "layout_v2/application"

  before_filter :find_consume, only: [:show, :edit, :update, :destroy]
  before_filter :find_consume_type, only: [:new, :edit]

  respond_to :html, :js

  def index
    @consumes = Consume.select("day(created_at) as day, year(created_at) as year,month(created_at) as month,sum(volue) as sum_value")
      .group("year(created_at),month(created_at),day(created_at)")
      .order("year(created_at),month(created_at),day(created_at)")
  end

  def show; end
  
  def detail
    #%c 月，数值(0-12),%m 月，数值(00-12); 
    #%e 月的天，数值(0-31),%d 月的天，数值(00-31)
    consumes = Consume.where("date_format(created_at,'%Y%c%e')=#{params[:consume_date]}")
    @sum_value, @sum_msg, @sum_tags =0, "", []
    for consume in consumes
      @sum_value += consume.volue
      @sum_msg += consume.msg+"\n"
      consume.tags.each do |tag|
	@sum_tags.push(tag)
      end if consume.tags
    end
    @sum_tags.uniq!

  end


  def new
    @consume = Consume.new
  end

  def create
    @consume = Consume.create(params[:consume])
    @consume.set_consume_type(params)
  end

  def edit; end

  def update
    #日期格式不匹配，则使用当前时间
    unless params[:consume][:created_at]=~ /\d+-\d+-\d+\s\d+:\d+:\d+/
      params[:consume][:created_at] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    end

    @consume.update_attributes(params[:consume])
    @consume.set_consume_type(params)
  end

  def destroy
    @consume.destroy
  end

  private

  def find_consume
    @consume = Consume.find(params[:id])
  end

  def find_consume_type
    @taggroups = Taggroup.all
      .select { |d| d.type == "consume" }
      .sort { |a, b| a.label <=> b.label }
  end

end

