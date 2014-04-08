#encoding: utf-8
module ConsumesHelper
 
  #小于10时填充0,比如7显示为07
  def day_nth(n)
    nth = (n.to_i < 10 ? "0#{n}" : n)
    return "第#{nth}天"
  end

  def y_m_d(c)
    y = c.year
    m = c.month
    d = c.day
    m = (m >= 10 ? m : "0#{m}")
    d = (d >= 10 ? d : "0#{d}")
    return "#{y}_#{m}_#{d}"
  end

end
