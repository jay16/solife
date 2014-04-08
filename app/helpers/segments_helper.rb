#encoding: utf-8
module SegmentsHelper

  #标签云显示
  def tags_cloud
    tags = []
    builds = SegmentsTag.select("tag_id,count(tag_id) as count").group("tag_id").order("count(tag_id) desc").limit(20);
    builds.each do |st|
      tag = Tag.find(st.tag_id)
      tags.push(tag) if tag.tag_type != 3 or tag.tag_type.nil?
    end
   tags
  end
 
  def segments_permlink(s,type=nil)
    d = s.created_at
    url = segments_permlink_path(d.year,d.month,d.day,s.permlink)
    return (type.nil? ? url : "#{url}#回复")
  end
  

  def topic_collect(topic)
    if topic then
      tag = Tag.where("label='#{topic.downcase}'").first
      lts = SegmentsTags.where("tag_id=#{tag.id}").map { |dd| dd.segment_id }
     tt = Segment.find(lts)
    else
     tt = [topic]
    end
  end

end
