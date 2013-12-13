class MemberTag < ActiveRecord::Base
  attr_accessible :member_id, :tag_id

  belongs_to :tag
  belongs_to :member
end
