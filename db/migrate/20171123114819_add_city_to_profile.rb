class AddCityToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :city_id, :integer
  end
end
