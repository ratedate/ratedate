class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.bigint :profile_id
      t.string :photo

      t.timestamps
    end
  end
end
