#encoding: utf-8
class Api::PhoneController < ApplicationController
  
  def update
    json = {
     :version => "1.1",
     :apk_name => "us.solife.consumes-1.1.apk",
     :describtion => "SOLife APK自动更新",
     :url => "http://solife-apk.qiniudn.com/us.solife.consumes.apk"
    }
    render :json => json
  end

end

