class CreateSegmentsTags < ActiveRecord::Migration
  def change
    create_table :segments_tags do |t|
      t.integer :segment_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
