class CreateTagImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images_tags do |t|
      t.references :tag
      t.references :image
      t.timestamps
    end
  end
end
