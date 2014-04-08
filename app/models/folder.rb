require 'fileutils'
class Folder < ActiveRecord::Base
  attr_accessible :desc, :is_public, :name, :folder_name
  has_many :photo_albums
  has_many :photos, :through => :photo_albums

  after_create :update_folder_name

  def update_folder_name
    self.update_attributes({
      :folder_name => UUIDTools::UUID.md5_create(UUIDTools::UUID_DNS_NAMESPACE, self.name+Time.now.to_s).to_s
    })

    folder_path = File.join(Rails.root,"public","photos",self.folder_name)
    FileUtils.mkdir_p(folder_path) unless !File.exist?(folder_path)
  end
end
