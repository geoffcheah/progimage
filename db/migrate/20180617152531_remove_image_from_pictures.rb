class RemoveImageFromPictures < ActiveRecord::Migration[5.1]
  def change
    remove_column :pictures, :image, :string
  end
end
