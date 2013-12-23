#encoding: utf-8
require "json"
module TrafficHelper

  def week_chart(hour_data)
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
      f.options[:title][:text] = "访客数据星期分布图"

      f.xAxis(:categories=> x_name)
      f.yAxis([{
        :title => {
          :text => "环比增率"
        }

      },{
        :title => {
          :text => "访客次数"
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
      f.series({:name=> '次数' , :type => 'column', :data=> click_num_data})
      f.series({:name=> '人次' , :type => 'column', :data=> click_peo_data})
      #右y轴
      f.series({:name=> '环比增加' ,
                :type => 'spline',
                :yAxis => 1,
                :tooltip => {
                    valueSuffix: ' %'
                },
                :data=> click_peo_data})
      f.tooltip({:enabled => true })
    end
  end

  def hour_chart(hour_data)
    #x_label内为数字，x_index内为字符串
    x_label = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    x_index = %w(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23)
    #x_name = %w(Sun Mon Tue Wed Thu Fri Sat)

    click_num_data = Array.new
    click_peo_data = Array.new
    x_index.each_with_index do |data,index|
      tmp = hour_data.select { |i| i.hour_index.to_i == index }[0]
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
      f.options[:title][:text] = "访客数据小时分布图"

      f.xAxis(:categories=> x_index)
      f.yAxis([{
        :title => {
          :text => "环比增率"
        }

      },{
        :title => {
          :text => "访客次数"
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
      f.series({:name=> '次数' , :type => 'column', :data=> click_num_data})
      f.series({:name=> '人次' , :type => 'column', :data=> click_peo_data})
      #右y轴
      f.series({:name=> '环比增加' ,
                :type => 'spline',
                :yAxis => 1,
                :tooltip => {
                    valueSuffix: ' %'
                },
                :data=> click_peo_data})
      f.tooltip({:enabled => true })
    end
  end

  def china_map_chart_data()
    provinces = %w(黑龙江 吉林 辽宁 河北 山东 江苏 浙江 安徽 河南 山西 陕西 甘肃 湖北 江西 福建 湖南 贵州 四川 云南 青海 海南 上海 重庆 天津 北京 宁夏 内蒙古 广西 新疆 西藏 广东 香港 台湾 澳门)
    chart_options = []
    IpMap.select("province, sum(count) as ip_num, count(*) as ip_peo")
      .where("province is not null")
      .group("province")
      .order("sum(count) desc").each_with_index do |info,index|

      tmp_p = provinces.select{ |p| info.province.include?(p) }[0]
      #chart_options.push("{'refer_to':'#{tmp_p}','fill':'red','title':'#{tmp_p}','body':'访客次数:#{info.ip_num.to_i}<br>访客人次:#{info.ip_peo}'}".to_json)
      chart_options.push({
        "refer_to" => tmp_p,
	"fill" => "rank_#{index+1}",
	"title" => tmp_p,
	"body" => "访客次数:#{info.ip_num.to_i}次</br>访客人次:#{info.ip_peo}人<br><a href='/traffics/map?province=#{info.province}' target='_blank'>详情查看</a>",
	"rank" => index,
	"label" => tmp_p,
	"text" => "#{info.ip_peo}/#{info.ip_num.to_i}"
      })
    end
    return chart_options
  end

  #饼状图
  def isp_chart()
    chart_data = []
    total_peo = 0
    IpMap.select("isp, sum(count) as isp_num, count(*) as isp_peo")
      .where("isp is not null")
      .group("isp")
      .order("sum(count) desc").each_with_index do |info,index|
      isp = (info.isp.nil? or info.isp == "" ? "其他" : info.isp)
      chart_data.push([isp,info.isp_peo])
      total_peo += info.isp_peo.to_i
    end
    #data = chart_data.map { |d| [d[0],(d[1]/total_peo).to_f.round(1)] }
    

    h = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:type] = "pie"
      f.options[:chart][:height] = "500"
      f.options[:chart][:width] = "800"
      f.options[:title][:text] = '互联网服务提供商比例图'
      f.options[:legend][:align] = "center"
      f.options[:legend][:verticalAlign] = "top"

      f.tooltip({:pointFormat => '{series.name}: <b>{point.percentage}%</b>',
                 :percentageDecimals => 1})
      f.plotOptions({:pie => { :allowPointSelect => true,
                               :cursor => 'pointer',
                               :dataLabels => { :enabled => true,
                                                :color => '#000000',
                                                :connectorColor => '#000000',
                                                :percentageDecimals => 1,
                                                :formatter => %|function(){
                                                  return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage,2) +' %';
                                                }|.js_code
                                               }
                              }
                      })
      f.series({:type => "pie",
                :name => "isp",
                :data => chart_data
               })
      f.tooltip({:enabled => true })
    end
  end
end
