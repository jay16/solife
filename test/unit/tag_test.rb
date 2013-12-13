require 'test_helper'

class TagTest < ActiveSupport::TestCase

  # called before every single test
  def setup
    Tag.create({:label => "system", :tag_type => 1}) if Tag.where("label='system'").size == 0
    Tag.create({:label => "public", :tag_type => 2}) if Tag.where("label='public'").size == 0
    Tag.create({:label => "private",:tag_type => 3}) if Tag.where("label='private'").size == 0
  end

  test "should not savet tag without label" do
     tag = Tag.new
     assert !tag.save, "Saved the tag without label"
  end

  test "should not save tag with label already exist" do
     tag = Tag.new({:label => "private", :tag_type => 3}) 
     assert !tag.save, "Save the tag with label already exist"
  end

  test "check tag type" do
     tag = Tag.find_by_label("private")
     assert_equal tag.tag_type, 3, "the type of tag with label 'private' is not 3"
  end

  test "should tag count more than  3" do
     count = Tag.all.count
     assert count >= 3, "should tag count more than  3, but is " + count.to_s
  end
end
