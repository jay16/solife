#encoding: utf-8
class LivesController < ApplicationController

  def coderay
  end

  def index
    @segments = Segment.paginate(:page => params[:page], :per_page => 5, :order => "created_at desc")

  end

  def new
    @life = Life.new

    respond_to { |format| format.js }
  end

  def edit
    @life = Life.find(params[:id])
    
    respond_to do |format| 
      format.js
      format.html
    end
  end

  def create
    title    = params[:title]
    subtitle = params[:subtitle]
    info     = params[:info]
    #segment is not necessnary
    segment  = params[:segment]
    
    life = {:title    => title,
            :subtitle => subtitle,
            :info     => info}
            
    @life=Life.create(life)
    
    if @life.save then 
      if segment then
        @life.segments.create({:content => segment}).save
      end
      render :text => "yes"
    else
      render :text => "no"
    end  
    
  end

  def update
   @life = Life.find(params[:id])
   @life.update_attributes(params[:life])

   respond_to { |format| format.js }
  end

  def destory
  end
  
  def segment_new
    respond_to { |format| format.js }
  end
  def segment_create
    segment_date = params[:segment_date]
    content      = params[:content]
    title        = params[:title]
    
    segment_date = params[:segment_date].nil? ? Time.now.strftime("%y-%m-%d") : params[:segment_date]

    lives = Life.where("to_days(lives_at) = to_days('#{segment_date}')")

    if lives.length == 0 then
      life = Life.create({
               :title => segment_date.encode("UTF-8"),
               :lives_at => segment_date.encode("UTF-8")}
             )
      life.save
    else
      life = lives.first
    end
    
    segment = {
            :title    => title.nil? ? segment_date : title.encode("UTF-8"),
            :content  => content.encode("UTF-8")
            }
            
    life.segments.create(segment).save
     
    respond_to { |format| format.js }
  end

  def segment_edit
    segment_id = params[:segment_id]
    @segment = Segment.find(segment_id)

    respond_to { |format| format.js }
  end
  
  def segment_update
    segment_id   = params[:segment_id]
    content      = params[:content]
    
    segment = Segment.find_by_id(segment_id)

    segment.segment_histories.create({:content => segment.content })
    segment.update_attribute(:content,content)   
    
    render :text => "update"
  end
  
  def destory_segment
    @life = Life.find(params[:life_id])
    @segment = @life.segments.find(params[:segment_id]).destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def segment_create_old
    life_id  = params[:life_id]
    content  = params[:content]
    
    @life = Life.find(life_id)
    #@segment = @life.segments.build
    
    segment = {
            :content  => content
            }
    
    if @life.segments.create(segment).save then 
      render :text => "yes"
    else
      render :text => "no"
    end  
  end
end
