class TodoTag < ActiveRecord::Base
  attr_accessible :todo_id, :tag_id

  belongs_to :tag
  belongs_to :todo
end
