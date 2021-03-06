class TrafficsController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
    @hour_data = Traffic.select("hour(created_at) as hour_index,count(*) as num, count(distinct ip) as peo")
              .group("hour(created_at)")
              .order("hour(created_at) asc")
    @week_data = Traffic.select("DATE_FORMAT(created_at,'%w') as week_index,count(*) as num, count(distinct ip) as peo")
	      .group("DATE_FORMAT(created_at,'%w')")
              .order("DATE_FORMAT(created_at,'%w') asc")
  end

  def list
    @traffics = Traffic.order("created_at desc").first(100)
  end

  def map
    @traffics = IpMap.where("province='#{params[:province]}'")
  end

  def show
    @traffic = Traffic.find(params[:id])
  end

  def destroy
  end

end
