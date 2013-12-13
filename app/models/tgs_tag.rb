class TgsTag < ActiveRecord::Base
  attr_accessible :tag_id, :taggroup_id
  belongs_to :tag
  belongs_to :taggroup
end
