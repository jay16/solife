#encoding: utf-8
module ApplicationHelper

  require "net/http"
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => "solife.faye"}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end


  def full_title(page_title)
    base_title = "SOLife - Segment Of Jay's Life"
    if page_title.nil?
      base_title
    else
      begin
        title = Segment.find_by_permlink(page_title).title
      rescue => e
        title = "No Found"
      end
      %Q{#{title} | #{base_title}}
    end
  end

  def jay_li
     User.find_by_email("jay_li@xsolife.com")
  end

  def week_name(index)
    case index
    when 0 then 'sunday'
    when 1 then 'monday'
    when 2 then 'tuesday'
    when 3 then 'wednesday'
    when 4 then 'thursday'
    when 5 then 'friday'
    when 6 then 'saturday'
    else
      'unkown'
    end
  end
  
  #界面加载segment.markdown时
  #若markdown为nil即调用该方法  
  def markdown(segment)
    segment.update_attribute(:markdown,Kramdown::Document.new(segment.content).to_html)
    return segment.markdown
  end

  def time_ago(tt)
    ss    = Time.now.to_i - tt.to_i
    days  = ss/60/60/24.to_i
    hours = ss/60/60%24.to_i
    mins  = ss/60%60.to_i
    str = (days > 0 ? "#{days}天前" : (hours > 0 ? "#{hours}时前" : (mins == 0 ? "刚刚" : "#{mins}分前")))
    tag = (days > 0 ? "default" : (hours > 0 ? "info" : "success"))
    return [tag, str]
  end

  #time format
  def f(t)
    case Time.now.strftime("%Y%m%d").to_i - t.strftime("%Y%m%d").to_i
    when 0 then t("date.today") + t.strftime(" %H:%M")
    when 1 then t("date.yesterday") + t.strftime(" %H:%M")
    when 2 then t("date.lastday") + t.strftime(" %H:%M")
    else t.strftime("%Y/%m/%d %H:%M") 
    end
  end
 
  require 'cgi'
  def escape(content)
    CGI::escape(content)
  end
  def escape_html(content)
    CGI::escapeHTML(content)
  end
  def unescape(content)
   CGI::unescape(content)
  end

  #js插件timeago
  def timeago(time, options = {})
    options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    content_tag(:abbr, "", options.merge(:title => time.iso8601)) if time
  end

  #显示notice alert
  def display_notice_and_alert
    msg = '<div class="alert">'
    msg << '<a class="close" data-dismiss="alert" href="#">&times;</a>'
    msg << alert
    msg << "</div>"

    sanitize msg
  end

  #把数组按指定数量分解
  #[1,2,3,4,5,6,7,8,9] => [[1,2,3],[4,5,6],[7,8,9]]
  def array_slice(array, count)
    return [[]] if array.empty? 

    length = array.length 
    times = (length%count == 0 ? length/count : length/count + 1)

    result, index = [], 0
    (1..times).each do |o|
      i_a = []
      (1..count).each do |i|
         i_a.push(array[index])
         index += 1
      end
      result.push(i_a)
    end
    return result
  end

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

end
