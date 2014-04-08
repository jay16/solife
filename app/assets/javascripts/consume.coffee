$(document).ready ->

  by_id = (id) ->
    document.getElementById(id)

  #确保consume的volue值为数字
  #数字时字体显示正常黑色
  #非数字时字体显示红色
  $("#consume_volue").keyup () ->
    source = by_id($(this).attr("id"))
    value  = source.value
    source.style.color =  (if isNaN(value) then "red" else "black")

  ######################################################## 
  #在写消费描述时，自动解析消费数值,eg:
  #100 - 公交卡充值
  #13 - 午餐
  #解析每行内容，以"-"分隔，剔除空格，判断数字，累加
  #累加内容直接赋值给consume_volue input
  $("#consume_msg").keyup () -> 
    source = by_id($(this).attr("id"))
    target = by_id("consume_volue")
    value  = source.value
    return false unless value

    sum_value = 0
    rows = value.split("\n")
    for row in rows
      value = row.split("-")[0].trim()
      sum_value += parseFloat(value) unless isNaN(value)	

    target.value = sum_value if !isNaN(sum_value)

  ######################################################## 
  #自定义函数 add_plus_date
  #按天为单位对日期进行加减
  self.add_plus_date = (add_or_plus) ->
    source = by_id("consume_created_at")
    reg = /^ *(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2})/
    match = source.value.match(reg)
    old_date = new Date(match[1],parseInt(match[2])-1,match[3],match[4],match[5],match[6])
    tmp_date = old_date.valueOf() + (if add_or_plus=="add" then +1 else -1)*24*60*60*1000 
    new_date = new Date(tmp_date)
    year  = new_date.getFullYear()
    month = new_date.getMonth() + 1
    day   = new_date.getDate() 
    hour  = new_date.getHours()
    minute= new_date.getMinutes()
    second= new_date.getSeconds()
    week  = switch new_date.getDay()
      when 0 then "Sun" 
      when 1 then "Mon"
      when 2 then "Tue"
      when 3 then "Wed"
      when 4 then "Thu"
      when 5 then "Fri"    
      when 6 then "Sat"
      else "Error"
    new_date_str = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second + " " + week
    source.value = new_date_str
    source.onfocus () ->
      source.value = new_date_str
    source.onblur () ->
      source.value = new_date_str
