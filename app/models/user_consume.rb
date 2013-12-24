class UserConsume < ActiveRecord::Base
  attr_accessible :consume_id, :user_id


  belongs_to :user
  belongs_to :consume
end
