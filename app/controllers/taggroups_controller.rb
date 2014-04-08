class TaggroupsController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
    @taggroups = Taggroup.all
  end

  def new
    @taggroup = Taggroup.new
  end

  def create
    @taggroup = Taggroup.create(params[:taggroup])
  end

  def show
    @taggroup = Taggroup.find(params[:id])
  end

  def edit
    @taggroup = Taggroup.find(params[:id])
  end
  
  def update
    @taggroup = Taggroup.find(params[:id])
    @taggroup.update_attributes(params[:taggroup])
  end

  def map
    @taggroups = Taggroup.all
    @tags = Tag.all

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def list
    @taggroups = Taggroup.all
    @tags = Tag.all
    @taggroup  = Taggroup.find(params[:taggroup_id])

    respond_to do |format|
      format.html { render :layout => false }
    end

  end
  
  def build
    taggroup = Taggroup.find(params[:taggroup_id])
 

    tags_sel = taggroup.tags.map{ |tag| tag.id }
    builds   = taggroup.tgs_tags
    tags_p   = []
    params.each { |k, v| tags_p.push(k.to_s.split(/_/)[-1].to_i) if k  =~ /tags_list/ }

    tags_new = tags_p - tags_sel
    tags_del = tags_sel - tags_p

    tags_new.each do |tag_id|
      taggroup.tgs_tags.create({:tag_id => tag_id })
    end

    tags_del.each do |tag|
      TgsTags.where("taggroup_id = #{taggroup_id} and tag_id = #{tag_id}").each do |build|
        build.destroy
      end
    end unless tags_del.empty?

    respond_to { |format| format.js  } 
  end
  
  def set_as_group
    tag_id = params[:tag_id]
    tag = Tag.find(tag_id)
    taggroups = Taggroup.where("tag_id=#{tag_id}")
    if taggroups.size == 0 then
     @taggroup = Taggroup.create({:tag_id => tag_id, :label => tag.label })
    else
     @taggroup = taggroups.first
    end
 
    respond_to { |format| format.js }
  end
end

