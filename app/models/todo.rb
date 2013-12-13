class Todo < ActiveRecord::Base
  attr_accessible :desc, :isover, :todo, :todo_type, :statu

  has_many :todo_tags, :dependent => :destroy
  has_many :tags, :through => :todo_tags

  #取得该modal所有的taggroup
  def taggroups
    Taggroup.all
      .select { |group| group.type == self.group_type }
      .sort { |a, b| a.label <=> b.label }
  end

  #取得该modal所属的taggroup
  def taggroup
    self.tags.first.taggroup(klass)
      .label if self.tags
  end

  #taggroup类别为类名consume
  def group_type
    klass
  end

  #该modal类名
  def klass
    self.class.to_s.downcase
  end

  def value
    self.volue
  end

  def set_todo_type(params)
    tags_sel = self.tags.map { |tag| tag.id }
    tags_p   = []
    params.each { |k, v| tags_p.push(k.to_s.split(/_/)[-1].to_i) if k  =~ /tag_/ }

    tags_new = tags_p - tags_sel
    tags_del = tags_sel - tags_p

    tags_new.each do |tag_id|
      next  if tag_id.nil?
      TodoTag.create({:todo_id => self.id, :tag_id => tag_id})
    end unless tags_new.empty?

    tags_del.each do |tag_id|
      TodoTag.where("todo_id = #{self.id} and tag_id = #{tag_id}").each do |build|
        build.destroy
      end
    end unless tags_del.empty?
  end
end
