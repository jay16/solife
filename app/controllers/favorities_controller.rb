#encoding: utf-8
class FavoritiesController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
    @favorities = Favority.all
  end

  def show
    @favority = Favority.find(params[:id])
  end

  def new
    @favority = Favority.new
  end

  def create
    @favority = Favority.create(params[:favority])
  end

  def edit
  end

  def update
    @favority = Favority.find(params[:id])
    if @favority.update(params[:favority])
      redirect_to(@favority)
    else
      render "edit"
    end
  end

  def destroy
  end

end

