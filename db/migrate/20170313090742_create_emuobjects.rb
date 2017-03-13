class CreateEmuobjects < ActiveRecord::Migration[5.0]
    def change
        create_table :emuobjects do |t|
            t.integer :irn, null: false
            t.text :description
            t.text :title
            t.text :taxonomy
            t.timestamps
        end
    end
end
