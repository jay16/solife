require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  def setup
    Segment.create({:content => "my text", :permlink => "segment-title"}) if Segment.where("permlink='segment-title'").size == 0
  end

  test "should not save segment without content" do
     segment = Segment.new
     assert !segment.save, "Saved the segment without content"
  end

  test "should exist the segment with permlink 'segment-title'" do
    segment = Segment.find_by_permlink("segment-title")
    assert_not_nil segment, "Segmnt with permlink 'segment-title' is not exist!"
  end

  test "should tag count more than  3" do
     count = Tag.all.count
     assert count >= 3, "should tag count more than  3, but is " + count.to_s
  end
 
  test "should update segment_tag after segment build tag" do
   segment = Segment.find_by_permlink("segment-title")
   segment.tags.create({:label => "private", :tag_type => 3})
   assert_equal segment.segment_type, 3, "Not update segment_tag after segment build tag and is " + segment.segment_type.to_s
  end
end
