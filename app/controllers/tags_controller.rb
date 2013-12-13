class TagsController < ApplicationController
  layout "layout_v2/application"

  before_filter :find_taggroup, only: [:new, :show, :create, :edit, :update]
  before_filter :find_tag, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @tags = Tag.all
  end

  def new
    @tag = @taggroup.tags.new
  end

  def create
    @tag = @taggroup.tags.create(params[:tag])
  end

  def show; end

  def edit; end

  def update
    @tag.update_attributes(params[:tag])
  end

  def destroy
    @tag.destroy
  end

  def build
    segment = Segment.find(params[:permlink].nil? ? params[:segment_id] : params[:permlink])
   
    tags_sel = segment.tags.map { |tag| tag.id }
    tags_p   = [] #params.map { |k, v| k.to_s.split(/_/)[-1].to_i if k  =~ /tags_list/ }
    params.each { |k, v| tags_p.push(k.to_s.split(/_/)[-1].to_i) if k  =~ /tags_list/ }

    tags_new = tags_p - tags_sel
    tags_del = tags_sel - tags_p

    tags_new.each do |tag_id|
      next  if tag_id.nil?
      SegmentsTag.create({:segment_id => segment.id, :tag_id => tag_id}).save
    end
    
    tags_del.each do |tag_id|  
      SegmentsTag.where("segment_id = #{segment.id} and tag_id = #{tag_id}").each do |build|
	build.destroy
      end
    end unless tags_sel.empty?

    @tags_zone = segment.tags
    privates = @tags_zone.map { |tag| tag if tag.tag_type == 3 }
    segment.update_attribte(:segment_type,3) unless privates.empty?
  end
  
  def list
    user = User.find(session[:user_id])
    @segment = (params[:segment_id].nil? ? Segment.find_by_permlink(params[:permlink]) : Segment.find(params[:segment_id]))
 
    @tags_list = user.tags
    @taggroups = Taggroup.all
    @tags_sel  = @segment.tags.map { |tag| tag.id }
    @tag       = Tag.new
  end
  
  def tags_zone
    segment_id = params[:segment_id]
    builds    = SegmentsTag.where("segment_id = #{segment_id}")
    @tags_list = Array.new
    
    if builds.length > 0 then 
      builds.each do |build|
        tag = Tag.find(build.tag_id)
        @tags_list.push(tag)
      end
    end
  end
  
  private

  def find_taggroup
    @taggroup = Taggroup.find(params[:taggroup_id])
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end
end

