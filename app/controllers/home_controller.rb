class HomeController < ApplicationController
  layout "layout_v2/application"

  respond_to :html, :js

  def index
  end

  def layout_v2
  end

  def layout_v1
    if session[:user_id]
      segments = Segment
    else
      segments = Segment.where("segment_type != 3 or segment_type is null")
    end
    @segments = segments.paginate(:page => params[:page], :per_page => 5, :order => "updated_at desc")
    @lastest_segments = Segment.order("updated_at desc").first(10)

    respond_to do |format|
      format.html { render :layout => "layouts/layout_v1/application" }
    end
  end

  #设置i18n多语言
  def i18
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale

    #render :js => "window.location.reload();"
    respond_to do |format|
      format.js { render :js => "window.location.reload();" }
    end
  end

end
