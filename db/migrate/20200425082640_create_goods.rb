class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string      :name,                   null: false, unique: true
      t.text        :explanation,            null: false
      t.integer	    :category_id,            null: false, foreign_key:true
      t.integer     :size_id,                foreign_key: true
      t.integer     :brand_id,               foreign_key: true
      t.integer     :condition_id,           null: false, foreign_key: true
      t.integer     :prefecture_id,          null: false,  foreign_key: true
      t.integer     :derivery_day_id,        null: false, foreign_key: true
      t.integer     :derivery_cost_id,       null: false, foreign_key: true
      t.integer     :price,                  null: false
      t.integer     :user_id,                null: false, foreign_key: true
      t.integer     :transaction_status_id,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
