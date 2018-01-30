class CreateSentGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :sent_gifts do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :gift_id
      t.string :message
      t.boolean :anonim, null: false, default: false
      t.boolean :hide, null: false, default: false

      t.timestamps
    end
    add_index :sent_gifts, :sender_id
    add_index :sent_gifts, :receiver_id
  end
end
