#encoding: utf-8
module FoldersHelper

  def label_level(num)
    case num
    when 0...100 then "info"
    when 100...300 then "success"
    else "important"
    end
  end

end
