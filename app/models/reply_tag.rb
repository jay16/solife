class ReplyTag < ActiveRecord::Base
  attr_accessible :reply_id, :tag_id

  belongs_to :tag
  belongs_to :reply
end
