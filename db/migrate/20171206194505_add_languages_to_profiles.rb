class AddLanguagesToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :languages, :string, array: true
    add_index :profiles, :languages, using: 'gin'
  end
end
