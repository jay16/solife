#encoding: utf-8
require 'nokogiri'
require 'open-uri'
require 'fileutils'
class PhotosController < ApplicationController

  respond_to :html, :js

  def new
    @folders = Folder.all
    @photo = Photo.new
  end

  def create
    @photos = Array.new
    if params[:web_album]
      @folder = Folder.find(params[:web_album])
      deal_with_webimg(@folder,@photos)
    elsif params[:local_album]
      @folder = Folder.find(params[:local_album])
      deal_with_local(@folder,@photos)
    elsif params[:imgurl_album]
      @folder = Folder.find(params[:imgurl_album])
      deal_with_imgurl(@folder,@photos)
    end
  end

  def show
    @folders = Folder.all

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if params[:path] and params[:path] != @photo.path
       path = params[:path]
       folder = File.join(Rails.root,"public","photos",@photo.folders.first.folder_name)
       new = File.join(folder,path)
       old = File.join(folder,@photo.path)
       FileUtils.mv(old,new) if new != old
    else
       path = @photo.path
    end
    @photo.update_attributes({:name => params[:name], 
       :desc => params[:desc],
       :path => path })
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
  end

  #通过ajax,根据提供的网址及css类名抓取图片
  def webimage
    url = params[:url]
    css = params[:css]
    doc = Nokogiri::HTML(open(url))
    @images = []
    doc.css(css).each do |img|
       @images.push(img.attr("src"))
    end
  end

  #3d gallery相册jquery插件 
  def gallery
    @folder = Folder.find(7)

    respond_to do |format|
      format.html { render :layout => "layouts/layout_v2/application" }
    end
  end

  private
  
  def chk_image_name(str)
    types = %w(.jpg .jpeg .png .bmp .gif .ico).select { |d| str.downcase.include?(d) }
    type = (types.empty? ? ".jpg" : types[0])

    name = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, str+Time.now.to_s).to_s
    return (name+type)
  end

  #根据提供的image url下载图片
  def deal_with_webimg(folder,photos)
    (0..50).each_with_index do |i,index|
      pimgurl, pimgchk, pimgdesc = "imgurl_#{i}", "accepted_#{i}", "desc_#{i}"

      next if params[pimgurl].nil? and params[pimgchk].nil?
       
      image_url  = params[pimgurl]
      image_name = chk_image_name(image_url)
      image_data = open(image_url){ |f| f.read }
      image_path = Rails.root.join("public","photos",folder.folder_name)

      FileUtils.mkdir_p(image_path) unless File.exist?(image_path)

      image_path = File.join(image_path, image_name)
      File.open(image_path, "wb") { |f| f.write(image_data) }

      photo = folder.photos.create({
       :name => image_name,
       :desc => params[pimgdesc],
       :original_name => image_url,
       :path => image_name
       })
      photos.push(photo)
    end
  end

  def deal_with_local(folder,photos)
    (0..50).each_with_index do |i,index|
      key = "file_#{i}"
      next if params[key].nil?

      image = params[key]

      original_name = image.original_filename.to_s
      image_name   = chk_image_name(original_name)
      image_path = Rails.root.join("public","photos",folder.folder_name)

      FileUtils.mkdir_p(image_path) unless File.exist?(image_path)

      image_path = File.join(image_path, image_name)
      File.open(image_path, "wb") { |f| f.write(image.read) }
      
      photo = folder.photos.create({
       :name => image_name,
       :desc => "upload at "+Time.now.strftime("%Y/%m/%d %H:%M:%S"),
       :original_name => original_name,
       :path => image_name
       })
      photos.push(photo)
    end
  end
end

