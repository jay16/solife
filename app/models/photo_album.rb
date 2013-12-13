class PhotoAlbum < ActiveRecord::Base
  attr_accessible :folder_id, :photo_id
  belongs_to :photo
  belongs_to :folder
end
