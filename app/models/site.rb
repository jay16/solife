class Site < ActiveRecord::Base
  attr_accessible :desc, :logo, :name, :url, :favority_id
end
