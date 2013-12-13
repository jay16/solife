class SessionsController < Devise::SessionsController
  layout "layout_v2/application"
  respond_to :html, :js

  def new
    super
  end

end
