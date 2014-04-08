#encoding: utf-8
class RepliesController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
    @replies = Reply.order("created_at desc")
    @segment = Segment.first
    @reply = @segment.replies.new
  end

  def new
    @segment = Segment.find_by_permlink(params[:permlink])
    @reply = @segment.replies.new
  end  

  def create
    @segment = Segment.find(params[:segment_id])
    @reply  = @segment.replies.create(params[:reply])
  end  
  
  def destroy
     @reply = Reply.find(params[:id])
     @reply.destroy 
  end
end

