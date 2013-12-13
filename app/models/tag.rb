#encoding: utf-8
class Tag < ActiveRecord::Base
  attr_accessible :label, :tag_type, :user_id
  validates :label, presence: true
  #validates :label, uniqueness: true
  #tag_type 1:sys 2:user 3:private

  has_many :segments_tags, :dependent => :destroy
  has_many :segments, :through => :segments_tags

  has_many :user_tags, :dependent => :destroy
  has_many :users, :through => :user_tags

  has_many :member_tags, :dependent => :destroy
  has_many :members, :through => :member_tags

  has_many :photo_tags, :dependent => :destroy
  has_many :photos, :through => :photo_tags

  has_many :reply_tags, :dependent => :destroy
  has_many :replies, :through => :reply_tags

  has_many :consume_tags, :dependent => :destroy
  has_many :consumes, :through => :consume_tags

  has_many :tgs_tags,  :dependent => :destroy
  has_many :taggroups, :through => :tgs_tags

  has_many :todo_tags, :dependent => :destroy
  has_many :todos, :through => :todo_tags


  #tag_type对应关系
  def type_map
    [["public",2],["private",3],["system",1]]
  end

  #根据tag_type显示不同级别
  def type
    klass = type_map.select { |dd| dd[1] == self.tag_type }
    klass.empty? ? "unknown" : klass[0][0]
  end

  #该标签所属分类
  def klass
    self.taggroups.map { |d| d.klass }.uniq
  end

  #该标签所属分类中实例数量
  #与taggroup的分类--对应
  def saze
    case self.klass[0]
    when "博客" then  self.segments.size
    when "图片" then self.photos.size
    when "消费记录" then self.consumes.size
    when "Edm会员" then self.members.size
    #when "留言" then self.replies.size
    else -1
    end
  end 

  #取是该modal所属的taggroup，排除system类型
  def taggroup(klass)
    self.taggroups
      .select { |taggroup| taggroup.type == klass }
      .first
  end
 
end
