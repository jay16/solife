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

end
