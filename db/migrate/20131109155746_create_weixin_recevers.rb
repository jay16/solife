class CreateWeixinRecevers < ActiveRecord::Migration
  def change
    create_table :weixin_recevers do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.text :content
      t.string :pic_url
      t.string :media_id
      t.string :format
      t.string :thumb_media_id
      t.string :location_x
      t.string :location_y
      t.string :scale
      t.string :label
      t.string :title
      t.text :description
      t.string :url
      t.string :msg_id
      t.string :event
      t.string :event_key
      t.string :ticket
      t.string :latitude
      t.string :longitude
      t.string :precision

      t.timestamps
    end
  end
end
