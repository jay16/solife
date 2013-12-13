class UserController < Devise::RegistrationsController #ApplicationController
  layout "layout_v2/application"

  before_filter :find_user, only: [:edit, :update, :show, :destroy]
  before_filter :find_user_tag, only: [:new, :edit]

  respond_to :html, :js
  def index
    @users = User.all

    respond_to do |format|
      format.html { render layout: "layout_v2/application" }
    end
  end

  def new
     super
  end

  def edit; end

  def update
    @user.update_attributes(params[:user])
  end

  def show; end

  
  def logout
    session[:user_id] = nil

    render :js => "window.location.reload();"
  end

  private
  
  def find_user
     @user = User.find(params[:id])
  end 

end
