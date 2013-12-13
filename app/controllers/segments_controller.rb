#encoding: utf-8
class SegmentsController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js
 
  def new
    @segment = Segment.new
    @taggroups = Taggroup.all
      .select { |d| d.type == "segment" }
      .sort { |a, b| a.label <=> b.label }
    
    render template: "segments/form", format: [:html], hander: [:erb],  layout: "layout_v2/application"
  end

  def create
    @segment = Segment.create(params[:segment])
    @segment.update_markdown_and_permlink
    @segment.set_segment_type(params)
    d = Time.now 
    redirect_to segments_permlink_path(d.year,d.month,d.day,@segment.permlink) 
  end

  def show
    @segment = Segment.find_by_permlink(params[:permlink])   
    @taggroups = Taggroup.all
      .select { |d| d.type == "segment" }
      .sort { |a, b| a.label <=> b.label }

    respond_to do |format|
      format.html {
	if @segment.nil?
	  render template: "exceptions/template", formats: [:html], hander: [:erb]
	elsif @segment.private? and session[params[:permlink].to_s].nil?
	  render template: "segments/personal", formats: [:html], hander: [:erb]
	else
           @reply = @segment.replies.new
	  render layout: "blog-segment", formats: [:html], hander: [:erb]
	end
      }
    end
  end

  def preview
    options = {:coderay_line_numbers => :table}
    markdown = Kramdown::Document.new(params[:content],options).to_html
    render text: markdown 
  end

  def edit
    @segment = Segment.find(params[:id])
    @taggroups = Taggroup.all
      .select { |d| d.type == "segment" }
      .sort { |a, b| a.label <=> b.label }

    render template: "segments/form", format: [:html], hander: [:erb],  layout: "layout_v2/application"
  end

  def update
    @segment = Segment.find(params[:id])
    @segment.update_attributes(params[:segment])
    @segment.update_markdown_and_permlink
    @segment.set_segment_type(params)

    d = Time.now 
    redirect_to segments_permlink_path(d.year,d.month,d.day,@segment.permlink) 
  end

  def update_markdown
    @segment = Segment.find(params[:id])
    @segment.update_attributes(params[:segment])

    redirect_to @segment.permlink_path
  end

  #显示某标签的segments
  def tags_show
   tags = params[:tags]
   tags = CGI::escapeHTML(tags).split(/,/).map { |t| "'#{t.downcase}'" }
   puts "*:"*10
   puts tags
   tags = tags.join(',')

   tags_sel = Tag.where("lower(label) in (#{tags})")
   if tags_sel.empty? then
     @tags = Tag.all
     render :template => "tags/tags_list", :locals => { :tags_list => @tags }
   else
     @tags = tags_sel
     @tags.each do |tag|
       (@segments.nil? ? @segments = tag.segments : @segments += tag.segments) if tag and tag.segments
     end
   end
  end

  #文章搜索
  def search
    keywords = params[:keywords].downcase
    @segments = Segment.where("lower(title) like '%#{keywords}%'")
  end

  #查看人个文章
  def personal
    pwords   = params[:private_words]

    if pwords and pwords=="Focus_01" then
      session[params[:permlink].to_s]="allow"
    end
  end

  def destory
    @segment = Segment.find(params[:id])
    @segment.destroy
  end

  def topic
    topic = params[:topic]
    permlink = params[:permlink]    

    if permlink then
      @segment = Segment.find_by_permlink(permlink)
    else
	    if topic then 
	      tag = Tag.where("label='#{topic.downcase}'").first
	      lts = SegmentsTag.where("tag_id=#{tag.id}").first
	      @segment = Segment.find(lts.segment_id)
	    else
	      @segment = Segment.all.first
	    end
    end
    
    @page_title = @segment.title 
    respond_to do |format|
     format.html { render :template => "segments/show", :layout => "ruby_in_100_minutes" }
    end
  end
 
  #给文章贴标签
  def attach_tags
    @taggroups = Taggroup.select { |d| d.type == "segment" }
    @segment = Segment.find(params[:segment_id])
  end
  def update_tags
    @segment = Segment.find(params[:segment_id])
    @segment.set_segment_type(params)
  end
  
end
