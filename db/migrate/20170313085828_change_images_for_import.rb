class ChangeImagesForImport < ActiveRecord::Migration[5.0]
  def change
      rename_column :images, :format, :mimeformat
      remove_column :images, :creator
      remove_column :images, :media_id
      remove_column :images, :description
      remove_column :images, :title
      add_column :images, :description, :text
      add_column :images, :title, :text
      add_column :images, :irn, :integer
      add_column :images, :notes, :text
      add_column :images, :mimetype, :string
      add_column :images, :inserted_at, :datetime
      add_column :images, :subjects, :text
      add_column :images, :department, :string
  end
end
