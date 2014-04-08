class Reply < ActiveRecord::Base
  attr_accessible :segment_id, :reply_id, :name, :email, :content
  validates :name, presence: true
  validates :content, presence: true

  belongs_to :segment

  has_many :reply_tags
  has_many :tags, :through => :reply_tags
end
