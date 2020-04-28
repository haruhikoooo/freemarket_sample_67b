class AddColumnToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :name, :string, null: false
    add_column :goods, :price, :integer, null: false
    add_column :goods, :transaction_status_id, :integer, null: false, foreign_key: true
  end
end
