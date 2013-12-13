require 'chk_mail'
class Member < ActiveRecord::Base
  attr_accessible :email, :issubscribed, :isvalid, :msg, :name, :member_type
  validates :email, presence: true, uniqueness: true
  after_create :validate_email

  has_many :member_tags
  has_many :tags, :through => :member_tags

  #取得该modal所有的taggroup
  def taggroups
    Taggroup.all
      .select { |group| group.type == self.klass }
      .sort { |a, b| a.label <=> b.label }
  end

  #取得该modal所属的taggroup
  def taggroup
    self.tags.first.taggroup(klass)
      .label if self.tags
  end

  #该modal类名
  def klass
    self.class.to_s.downcase
  end

  def set_member_type(params)
    tags_sel = self.tags.map { |tag| tag.id }
    tags_p   = []
    params.each { |k, v| tags_p.push(k.to_s.split(/_/)[-1].to_i) if k  =~ /tag_/ }

    tags_new = tags_p - tags_sel
    tags_del = tags_sel - tags_p

    tags_new.each do |tag_id|
      next  if tag_id.nil?
      MemberTag.create({:member_id => self.id, :tag_id => tag_id})
    end unless tags_new.empty?

    tags_del.each do |tag_id|
      MemberTag.where("member_id = #{self.id} and tag_id = #{tag_id}").each do |build|
        build.destroy
      end
    end unless tags_del.empty?
  end

  #=============================================================

  def default_froms
    [["jay_li@xsolife.com","mx.ym.163.com"],
     ["527130673@qq.com","mx1.qq.com"],
    ["solife_li@sina.com","freemx3.sinamail.sina.com.cn"],
    ["solife.jay@gmail.com","alt3.gmail-smtp-in.l.google.com"]]
  end

  #member_type对应关系
  def type_map
    [["admin",1],["member",2]]
  end

  #根据member_type显示不同级别
  def type
     klass = type_map.select { |dd| dd[1] == self.member_type }
     klass.empty? ? "unknown" : klass[0][0]
  end

  def domain
    domain = self.email.match(/\@(.+)/)[1]
  end

  #查看该会员邮箱的mx记录列表
  def mx
    mxes = Mx.where(["domain = :d", { :d => domain }]).order("preference desc")
  end

  #最得最侍mx记录,与chk_email_mx呼应
  def best_mx
    mx ? mx.first : chk_email_mx
  end

  #非同Mx Exchange邮箱发信
  def from
    default_froms.select { |d| d[1] != best_mx.exchange }[0][0]
  end
  #验证会员邮箱是否有效 
  def validate_email
    bestmx = best_mx
    ret = SOLife::ChkMail.validate(bestmx.exchange,from,email)

    bestmx.update_attributes({ :updated_at => Time.now }) if ret[0] 
    self.update_attributes({ :isvalid => ret[0], :msg => ret[1] })
  end

  #检测该会员email MX记录
  def chk_email_mx
    mx = SOLife::ChkMail.get_mx(domain) 
    if mx.empty?
      Mx.create({:domain => doamin, :exchange => nil, :preference => nil })
    else
      mx.each do |m|
        Mx.create({:domain => doamin, :exchange => m.exchange.to_s, :preference => mx.preference })
      end 
    end
    return best_mx
  end


end
