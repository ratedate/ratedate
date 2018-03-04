class CreateEtzInvestments < ActiveRecord::Migration[5.1]
  def change
    create_table :etz_investments do |t|
      t.string :wallet
      t.datetime :time
      t.decimal :etz
      t.decimal :rdt

      t.timestamps
    end
  end
end
