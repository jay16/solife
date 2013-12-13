class ConsumeTag < ActiveRecord::Base
  attr_accessible :consume_id, :tag_id

  belongs_to :tag
  belongs_to :consume
end
