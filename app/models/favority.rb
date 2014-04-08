class Favority < ActiveRecord::Base
  attr_accessible :desc, :label, :klass
  validates :label, presence: true, uniqueness: true
  has_many :sites
end
