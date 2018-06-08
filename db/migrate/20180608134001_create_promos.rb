class CreatePromos < ActiveRecord::Migration[5.1]
  def change
    create_table :promos do |t|
      t.string :promocode
      t.string :status, default: 'available'
      t.string :promo_type, default: 'rdt'
      t.decimal :value
      t.integer :user_id
      t.string :create_session

      t.timestamps
    end
    add_index :promos, :promocode, unique: true
  end
end
