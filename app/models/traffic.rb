class Traffic < ActiveRecord::Base
  attr_accessible :action, :browser, :controller, :ip, :url, :userid, :created_at, :updated_at, :track_type

  #track_type对应关系
  def type_map
    [["segment",1],["edm-track",2],["edm-click",3]]
  end

  #根据tag_type显示不同级别
  def type
    klass = type_map.select { |dd| dd[1] == self.track_type }
    klass.empty? ? "unknown" : klass[0][0]
  end
end
