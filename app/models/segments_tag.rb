class SegmentsTag < ActiveRecord::Base
  attr_accessible :segment_id, :tag_id

  belongs_to :segment
  belongs_to :tag
end
