#encoding: utf-8
class Taggroup < ActiveRecord::Base
  attr_accessible :isprivate, :label, :tag_id, :group_type
  has_many :tgs_tags, dependent: :destroy
  has_many :tags, :through => :tgs_tags

  def mappings
    [[["segment","博客"],1],
      [["member","Edm会员"],2],
      [["photo","图片"],3],
      [["reply","留言"],4], 
      [["consume","消费记录"],5],
      [["user","用户"],6],
      [["todo","待做事项"],7],
      [["system","系统"],0]
    ]
  end

  #映射为二维数组，
  #在创建taggroup的_form中选择使用
  def type_map
    mappings.map { |d| [d[0][0],d[1]] }
  end

  def klass_map
    mappings.map { |d| [d[0][1],d[1]] }
  end

  #映射为一维数组
  #当前tag所性的taggroup群
  def types
    klass = mappings.select { |dd| dd[1] == self.group_type }
    klass.empty? ? "unknown" : klass[0][0]
  end

  #当前tag所属taggroup群第一个
  #server比较使用字母
  def type
    types[0]
  end

  #ui显示使用中文
  def klass
    types[1]
  end

end
