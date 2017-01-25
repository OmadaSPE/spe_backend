class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string      :title
      t.string      :description
      t.integer     :media_id
      t.string      :creator
      t.string      :format
      t.timestamps
    end
    add_index :images, :media_id, unique: true
  end
end
