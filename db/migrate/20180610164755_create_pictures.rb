class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :description
      t.string :remote_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
