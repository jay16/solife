module TaggroupsHelper
  
  def is_taggroup(tag)
    Taggroup.where("tag_id=#{tag.id}").size > 0 ? true : false
  end

  def tag_group(taggroup)
    lists = TgsTags.where("taggroup_id=#{taggroup.id}")
    tags = []
    if !lists.nil?
      lists.each { |list| tags.push(Tag.find(list.tag_id)) }
    end
    return tags
  end
 
  def is_tag_private(tag)
     tag.tag_type == 3 ? true : false
  end
  
end
