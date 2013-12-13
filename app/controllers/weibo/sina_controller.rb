#encoding: utf-8
require "yaml/store"
class Weibo::SinaController < ApplicationController
  layout "layout_v2/application"

  before_filter :chk_weibo,   except: [:connect, :callback]
  respond_to    :xml, :html, :js
  
  def index
    #微博注册的个信息
    @user     = @sina_client.users.show_by_uid(@sina_config["user"]["uid"])
    #我发布的微博
    @statuses = @sina_client.statuses
  end

  def connect
    client = WeiboOAuth2::Client.new
    redirect_to client.authorize_url
  end

  def callback
    unless params[:code] then
       redirect_to "/"
    else

    client = WeiboOAuth2::Client.new
    access_token = client.auth_code.get_token(params[:code].to_s)

    session[:uid] = access_token.params["uid"]
    session[:access_token] = access_token.token
    session[:expires_at] = access_token.expires_at

    weibo_config = YAML::Store.new("config/weibo.yaml")
    weibo_config.transaction do
      weibo_config["sina"]["user"]["uid"] = access_token.params["uid"]
      weibo_config["sina"]["user"]["access_token"] = access_token.token
      weibo_config["sina"]["user"]["expires_at"] = access_token.expires_at
    end

    redirect_to "/weibo/sina"
    end
  end
    
  private

  def chk_weibo
    weibo_config = YAML.load_file("config/weibo.yaml")
    @sina_config = weibo_config["sina"]

    WeiboOAuth2::Config.api_key      = @sina_config["app_key"]
    WeiboOAuth2::Config.api_secret   = @sina_config["app_secret"]
    WeiboOAuth2::Config.redirect_uri = @sina_config["redirect_uri"]   

    if Time.at(@sina_config["user"]["expires_at"].to_i) < Time.now
      redirect_to "/weibo/sina/connect"
    end

    @sina_client = WeiboOAuth2::Client.new
    @sina_client.get_token_from_hash({
      :access_token => @sina_config["user"]["access_token"],
      :expires_at => @sina_config["user"]["expires_at"]
    })
  end

end
