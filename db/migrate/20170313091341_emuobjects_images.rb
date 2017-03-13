class EmuobjectsImages < ActiveRecord::Migration[5.0]
  def change
      create_table :emuobjects_images do |t|
        t.references :emuobject
        t.references :image
        t.timestamps
      end
  end
end
