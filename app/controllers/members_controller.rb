#encoding: utf-8
class MembersController < ApplicationController
  layout "layout_v2/application"

  before_filter :find_member, only: [:show, :mx, :edit, :update, :destroy]
  before_filter :find_member_type, only: [:new, :edit]

  respond_to :html, :js

  def index
    @members = Member.all
  end

  def show;end

  def mx
    @mxes = @member.mx
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.create(params[:member])
    @member.set_member_type(params)
  end

  def edit;end

  def update
    @member.update_attributes(params[:member])
    @member.set_member_type(params)
  end

  def destroy
    @member.destroy
  end

  def validate
    @member.validate_email
  end

  private

  def find_member
    @member = Member.find(params[:id])
  end

  def find_member_type
    @taggroups = Taggroup.all
      .select { |d| d.type == "member" }
      .sort { |a, b| a.label <=> b.label }
  end
end

