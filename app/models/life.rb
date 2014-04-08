class Life < ActiveRecord::Base
  attr_accessible :info, :subtitle, :title, :lives_at
  has_many :segments #,:dependent => :destory
end
