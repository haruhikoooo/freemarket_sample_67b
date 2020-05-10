class RemoveColumnUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :family_name, :string, null: false
    remove_column :users, :first_name, :string, null: false
    remove_column :users, :furigana_family, :string, null: false
    remove_column :users, :furigana_first, :string, null: false
    remove_column :users, :birthday, :date, null: false
  end
end
