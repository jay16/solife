class CreateIpMaps < ActiveRecord::Migration
  def change
    create_table :ip_maps do |t|
      t.string :ip
      t.string :ret
      t.string :message
      t.string :country
      t.string :province
      t.string :city
      t.string :county
      t.string :isp
      t.string :area
      t.integer :count

      t.timestamps
    end
  end
end
