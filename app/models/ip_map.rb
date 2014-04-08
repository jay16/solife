class IpMap < ActiveRecord::Base
  attr_accessible :area, :city, :country, :county, :ip, :isp, :message, :province, :ret, :count
end
