class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.boolean :hide_surname
      t.string :nickname
      t.string :avatar
      t.date :dob
      t.boolean :hide_dob
      t.string :gender
      t.text :about

      t.timestamps
    end
  end
end
