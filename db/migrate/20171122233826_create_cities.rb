class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :country
      t.string :country_code
      t.string :city
      t.string :administrative_area_level_2
      t.string :administrative_area_level_1

      t.timestamps
    end
  end
end
