require 'fileutils'
class FoldersController < ApplicationController
  layout "layout_v2/application" 

  respond_to :html, :js

  def dindex
    @folders = Folder.all
  end

  def index
    @folders = Folder.all
    @photos = Photo.all
    @folder = Folder.new
    @photo = Photo.new
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = Folder.create(params[:folder])
  end

  def edit; end

  def show
    @folder = Folder.find(params[:id])
  end

  def upload
    @folders = Folder.all
    @photo = Photo.new
  end

  def destroy
    @folder = Folder.find(params[:folder_id])

    #只允许删除空相册
    if @folder.photos.size == 0 
      folder_path = File.join(Rails.root,"public","photos",@folder.folder_name)
      FileUtils.rm_r(folder_path) if !File.exist?(folder_path)    
      @folder.destroy 
    end

  end

  def list
    @folder = Folder.find(params[:folder_id])

   respond_to do |format|
     format.html { render :layout => false }
   end  
  end

  def set_folder
    Folder.all.each do |f|
      uuid = UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, f.name+Time.now.to_s).to_s

      base = File.join(Rails.root,"public","photos")
      old = File.join(base, f.folder_name)      
      new = File.join(base, uuid)
      FileUtils.mv(old, new)
      if File.exist?(new)
        f.update_attribute(:folder_name,uuid) 
      end
    end
    render :text => "over"
  end
end

