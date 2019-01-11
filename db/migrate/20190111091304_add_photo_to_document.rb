class AddPhotoToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :photo, :string
  end
end
