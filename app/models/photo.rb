class Photo < ActiveRecord::Base
  attr_accessible :desc, :name, :path, :original_name
  has_many :photo_albums
  has_many :folders, :through => :photo_albums

  def folder_path
    self.folders.first.folder_name
  end
end
