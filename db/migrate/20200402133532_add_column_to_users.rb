class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :family_name, :string
    add_column :users, :first_name, :string
    add_column :users, :furigana_family, :string
    add_column :users, :furigana_first, :string
    add_column :users, :birth_day, :datetime
  end
end
