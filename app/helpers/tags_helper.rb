module TagsHelper
  
  def tags_list
    if current_user then
      tags = Tag.where("user_id = #{current_user.id}")
    end
  end
end
