#encoding: utf-8
module ConsumesHelper
 
  #小于10时填充0,比如7显示为07
  def day_nth(n)
    nth = (n.to_i < 10 ? "0#{n}" : n)
    return "第#{nth}天"
  end

end
