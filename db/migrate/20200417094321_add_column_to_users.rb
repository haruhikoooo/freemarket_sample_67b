class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, unique: true
    add_column :users, :family_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :furigana_family, :string, null: false
    add_column :users, :furigana_first, :string, null: false
    add_column :users, :birthday, :date, null: false
  end
end
