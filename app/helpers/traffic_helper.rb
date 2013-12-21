#encoding: utf-8
module TrafficHelper

  def chart(hour_data)
    #x_label内为数字，x_index内为字符串
    x_label = [0,1,2,3,4,5,6]
    x_index = %w(0 1 2 3 4 5 6)
    x_name = %w(Sun Mon Tue Wed Thu Fri Sat)

    click_num_data = Array.new
    click_peo_data = Array.new
    x_index.each_with_index do |data,index|
      tmp = hour_data.select { |i| i.week_index.to_i == index }[0]
      click_num_data.push(tmp==nil ? 0 :tmp.num)
      click_peo_data.push(tmp==nil ? 0 :tmp.peo)
    end

    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:zoomType] = "xy"
      f.options[:chart][:height] = "500"
      f.options[:chart][:width] = "800"

      f.options[:legend][:align] = "center"
      f.options[:legend][:layout] = "horizontal"
      f.options[:legend][:verticalAlign] = "bottom"
      f.options[:title][:text] = "访客数据分布图"

      f.xAxis(:categories=> x_name)
      f.yAxis([{
        :title => {
          :text => "Clicks|Tracks"
        }

      },{
        :title => {
          :text => "Clicks/Tracks"
        },
        :labels => {
          :formatter => %|function() {
                return this.value +'%';
            }|.js_code,
          :style => {
                :color => '#89A54E'
            }
        },
        :opposite => true
      }])

      #左y轴
      f.series({:name=> 'Clicks' , :type => 'column', :data=> click_num_data})
      f.series({:name=> 'Tracks' , :type => 'column', :data=> click_peo_data})
      #右y轴
      f.series({:name=> 'Click Rate' ,
                :type => 'spline',
                :yAxis => 1,
                :tooltip => {
                    valueSuffix: ' %'
                },
                :data=> click_peo_data})
      f.tooltip({:enabled => true })
    end
  end


  def china_map_chart()
    provinces = %w(黑龙江 吉林 辽宁 河北  山东 江苏 浙江 安徽 河南 山西,  陕西 甘肃 湖北 江西 福建 湖南 贵州 四川 云南 青海 海南 上海 重庆 天津 北京 宁夏 内蒙古 广西 新疆 西藏 广东 香港 台湾 澳门)
    chart_options = []
    IpMap.select("province, sum(count) as ip_num, count(*) as ip_peo")
      .where("province is not null")
      .group("province")
      .order("sum(count) desc").each_with_index do |info,index|

      tmp_p = provinces.select{ |p| info.province.include?(p) }[0]
      chart_options.push({
        "refer_to" => tmp_p,
	"fill" => "red",
	"title" => tmp_p,
	"body" => "访客次数:#{info.ip_num.to_i}<br>访客人次:#{info.ip_peo}"
      })
    end
    return chart_options
  end
end
