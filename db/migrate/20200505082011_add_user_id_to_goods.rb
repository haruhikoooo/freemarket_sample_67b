class AddUserIdToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :user_id, :integer, null: false, foreign_key: true
  end
end
