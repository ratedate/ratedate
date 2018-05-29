class AddEthToEtzInvestments < ActiveRecord::Migration[5.1]
  def change
    add_column :etz_investments, :eth, :decimal
  end
end
