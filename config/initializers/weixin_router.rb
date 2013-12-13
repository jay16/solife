#encoding : utf-8
module Weixin
  # 微信内部路由规则类，用于简化配置
  class Router

    # 支持以下形式
    # WeixinRouter.new(:type=>"text")
    # WeixinRouter.new(:type=>"text", :content=>"Hello2BusUser")
    # WeixinRouter.new(:type=>"text", :content=>/^@/)
    # WeixinRouter.new {|xml| xml[:MsgType] == 'image'}
    # WeixinRouter.new(:type=>"text") {|xml| xml[:Content].starts_with? "@"}
    def initialize(options, &block)
      @type = options[:type] if options[:type]
      @content = options[:content] if options[:content]
      @constraint = block if block_given?
    end

    def matches?(request)
      xml = request.params[:xml]
      result = true
      result = result && (xml[:MsgType] == @type) if @type
      result = result && (xml[:Content] =~ @content) if @content.is_a? Regexp
      result = result && (xml[:Content] == @content) if @content.is_a? String
      result = result && @constraint.call(xml) if @constraint

      return result
    end
  end

  module ActionController
    # 辅助方法，用于简化操作，weixin_xml.content 比用hash舒服多了，对不？
    def weixin_xml
      @weixin_xml ||= WeixinXml.new(params[:xml])
      return @weixin_xml
    end

    class WeixinXml
      attr_accessor :to_user_name, :from_user_name, :create_time, :msg_type, :msg_id
      attr_accessor :content                                 #text
      attr_accessor :pic_url, :media_id                      #image
      attr_accessor :media_id, :format                       #voice
      attr_accessor :media_id, :thumb_media_id               #video
      attr_accessor :location_x, :location_y, :scale, :label #location
      attr_accessor :title, :description, :url               #link
      attr_accessor :event, :event_key, :ticket              #event, scan
      attr_accessor :event, :latitude, :longitude, :precision

      def initialize(hash)
        @to_user_name = hash[:ToUserName]
	@from_user_name = hash[:FromUserName]
	@create_time = hash[:CreateTime]
	@msg_type = hash[:MsgType]
	@msg_id = hash[:MsgId]
        @content = hash[:Content]
        @pic_url = hash[:PicUrl]
	@media_id = hash[:MediaId]
	@format = hash[:Format]
	@thumb_media_id = hash[:ThumbMediaId]
	@location_x = hash[:Location_X]
	@location_y = hash[:Location_Y]
	@scale = hash[:Scale]
	@label = hash[:Label]
	@title = hash[:Title]
	@description = hash[:Description]
	@url = hash[:Url]
	@event = hash[:Event]
	@event_key = hash[:EventKey]
	@ticket = hash[:Ticket]
	@latitude = hash[:Latitude]
	@longitude = hash[:Longitude]
	@precision = hash[:Precision]
      end
    end
  end
end

ActionController::Base.class_eval do
  include ::Weixin::ActionController
end
ActionView::Base.class_eval do
  include ::Weixin::ActionController
end
