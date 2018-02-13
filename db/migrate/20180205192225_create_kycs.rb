class CreateKycs < ActiveRecord::Migration[5.1]
  def change
    create_table :kycs do |t|
      t.string :wallet
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.string :country
      t.string :address_line_1
      t.string :address_line_2
      t.string :state
      t.string :province
      t.string :postal_code
      t.string :identity_photo
      t.string :address_photo

      t.timestamps
    end
  end
end
