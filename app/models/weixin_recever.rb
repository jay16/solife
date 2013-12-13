class WeixinRecever < ActiveRecord::Base
  attr_accessible :to_user_name, :from_user_name, :create_time, :msg_type, :msg_id 
  attr_accessible :content                                 #text
  attr_accessible :pic_url, :media_id                      #image
  attr_accessible :media_id, :format                       #voice
  attr_accessible :media_id, :thumb_media_id               #video 
  attr_accessible :location_x, :location_y, :scale, :label #location 
  attr_accessible :title, :description, :url               #link 
  attr_accessible :event, :event_key, :ticket              #event, scan
  attr_accessible :event, :latitude, :longitude, :precision

  #to_user_name:string 开发者微信号 
  #from_user_name:string 发送方帐号（一个OpenID） 
  #create_time: datetime 消息创建时间 （整型）
  #msg_type:string text 
  #content:text 文本消息内容
  #pic_url:string 图片链接 
  #media_id:string 图片消息媒体id，可以调用多媒体文件下载接口拉取数据。 
  #format:string 语音格式，如amr，speex等
  #thumb_media_id:string 视频消息缩略图的媒体id，可以调用多媒体文件下载接口拉取数据。 
  #location_x:string 地理位置维度 
  #location_y:string 地理位置精度 
  #scale:string 地图缩放大小 
  #label:string 地理位置信息 
  #title:string 消息标题 
  #description:text 消息描述
  #url:string 消息链接
  #msg_id:string 消息id，64位整型 
  #event:string 事件类型，subscribe(订阅)、unsubscribe(取消订阅) 
  #event_key:string 事件KEY值，qrscene_为前缀，后面为二维码的参数值
  #ticket:string 二维码的ticket，可用来换取二维码图片  
  #latitude:string 地理位置纬度 
  #longitude:string 地理位置经度 
  #precision:sstring 地理位置精度 
end
