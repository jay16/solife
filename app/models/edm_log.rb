class EdmLog < ActiveRecord::Base
  attr_accessible :edm_id, :frem, :tu, :subject, :created_at
  attr_accessible :statu, :begin, :duration, :ip, :method, :send_type 

  belongs_to :edm


  def from
    frem
  end

  def to
    tu
  end
end
