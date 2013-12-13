#encoding: utf-8
class Segment < ActiveRecord::Base
  attr_accessible :life_id, :content, :title, :markdown, :permlink, :segment_type
  validates :content, presence: true
  validates :title, uniqueness: true

  belongs_to :life
  has_many :replies
  has_many :drafts
  has_many :segments_tags
  has_many :tags , :through => :segments_tags

  #segment_type对应关系
  def type_map
    [[["blog","博客"],1],[["edm","Edm模板"],2],
     [["TODO","待做"],3],[["essay","随笔"],4]
    ]
  end

  #根据segment_type显示不同级别
  def types
    klass = type_map.select { |dd| dd[1] == self.segment_type }
    klass.empty? ? "unknown" : klass[0][0]
  end

  #server分类使用
  def type
    types[0]
  end

  #ui显示使用
  def klass
    types[1]
  end

  def private?
    self.tags and !self.tags.select { |tag| tag.type == "private" }.empty?
  end

  def update_markdown_and_permlink
    #PinYin.permlink 会将 
    #"rails simple router and nested router" => "rails-simple-router-and-nested-router"
    #"rails-simple-router-and-nested-router" => "railssimplereouterandnestedrouter"
    #需要"rails-simple-router-and-nested-router".gsub("-"," ") => "rails-simple-router-and-nested-router"

    options = {:coderay_line_numbers => :table}
    self.update_attributes({
      :markdown => Kramdown::Document.new(self.content,options).to_html,
      :permlink => PinYin.permlink(self.permlink ? self.permlink.gsub("-"," ") : self.title)
    })
  end

  def set_segment_type(params)
    tags_sel = self.tags.map { |tag| tag.id }
    tags_p   = []
    params.each { |k, v| tags_p.push(k.to_s.split(/_/)[-1].to_i) if k  =~ /tag_/ }

    tags_new = tags_p - tags_sel
    tags_del = tags_sel - tags_p

    tags_new.each do |tag_id|
      next  if tag_id.nil?
      SegmentsTag.create({:segment_id => self.id, :tag_id => tag_id})
    end unless tags_new.empty?

    tags_del.each do |tag_id|
      SegmentsTag.where("segment_id = #{self.id} and tag_id = #{tag_id}").each do |build|
        build.destroy
      end
    end unless tags_del.empty?
  end

  def permlink_path
    d = self.created_at
    "/#{d.year}/#{d.month}/#{d.day}/#{self.permlink}"
  end
end
