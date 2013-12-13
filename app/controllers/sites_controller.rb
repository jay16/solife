#encoding: utf-8
require 'nokogiri'
require 'open-uri'
class SitesController < ApplicationController
  layout false

  before_filter :find_favority, only: [:show, :new, :create, :edit, :update]
  before_filter :find_site, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @sites = Site.all
  end

  def show; end

  def new
    @site = @favority.sites.new
  end

  def create
    @site = @favority.sites.create(params[:site])
  end

  def edit; end

  def update
    @site.update_attributes(params[:site])
  end

  def destroy
    @site.destroy
  end

  def site_title
    url = params[:url]
    doc = Nokogiri::HTML(open(url))
    titles = doc.search('title')
    title = titles[0].content.strip unless titles.empty?

    render :text => (title.nil? ? "GetFail" : title)
  end

  private

  def find_favority
    @favority = Favority.find(params[:favority_id])
  end

  def find_site
    @site = Site.find(params[:id])
    #@site = @favority.sites.find(params[:id])
  end

end

