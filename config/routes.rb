#encoding: utf-8
Solife::Application.routes.draw do
  root :to => "home#index"

  devise_for :users,
    :controllers => {
#      :registrations => :users,
      :sessions => :sessions
  }

  #处理weixin消息
  scope :path => "/weixin", :via => :post, :defaults => {:format => "xml"} do 
    #接收事件推送
    root :to => "weixin#event", :constraints => Weixin::Router.new(:type => "event")
    #接收普通消息
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "text")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "image")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "voice")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "video")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "location")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "link")
    root :to => "weixin#other" #没有被处理到的事件
  end
  match "/weixin" => "weixin#authen", :via => :get
  match "/weixin/:id" => "weixin#show", :as => :weixin

  namespace :weibo do
    resources :sina do
      collection do
	get  "callback"
	post  "callback"
	get "connect"
      end
    end
  end

  resources :members do
    member do
      get "validate"
      get "mx"
    end
  end
  resources :mxes

  match "/photos"         => "photos#gallery"
  match "/photos/set"     => "photos#set"
  match "/upload/photos"  => "folders#upload", :as => :upload_photos

  resources :folders do
    resources :photos
  end


  match "/site/title" => "sites#site_title", :as => :site_title
  resources :favorities do
    resources :sites
  end


  resources :taggroups do
    resources :tags
  end

  match "/api/sendmail" => "edms#api_sendmail"
  resources :edms do
    post "deliver"
    resources :edm_logs
  end

  #resources :users

  resources :segments do
    get  "attach_tags"
    post "update_tags"

    resources :replies, shallow: true
  end

  resources :links
  resources :todos
  resources :consumes
  match "/consumes/:consume_date/detail" => "consumes#detail", :as => :consume_detail

  resources :traffics
  match "/traffics/chart" => "traffics#chart"

  match "/v2"   => "home#layout_v2"  
  match "/v1"   => "home#layout_v1" , :as => :v1
  match "/blog" => "home#layout_v1" , :as => :blog
  match "/home/i18" => "home#i18",    :as => :i18
  match "/shell"    => "demo#shell"

  match "/search/segments"            => "segments#search",          :as => :segments_search
  match ":year/:month/:day/:permlink" => "segments#show",            :as => :segments_permlink

  match "/view/:year/:month/:day/:permlink/personal" => "segments#personal",   :as => :view_personal
  match "/tags/:tags"                                => "segments#tags_show",  :as => :segments_tags_show

  #match "/replies/:permlink/new"    => "replies#new",    :as => :replies_new
  #match "/replies/:permlink/create" => "replies#create", :as => :replies_create
  match "/replies/:id/destroy"      => "replies#destroy",:as => :replies_destroy

  match "demo/openfind"        => "tools_openfind#index"
  match "demo/markdown-editor" => "demo#markdown_editor", :as => :editor_demo
  match "demo/ruby-in-100-minutes" => "demo#ruby_in_100_minutes"
  match "/resume"        => "demo#resume"
  match "guides/:topic"  => "segments#topic"
  match "guides/:topic/:permlink"  => "segments#topic", :as => :segments_topic


  match ":controller(/:action(/:id))(.:format)"
  #mount Resque::Server.new, :at => "/resque"
  match "*a", :to  => "application#deal_with_exceptions"
end
