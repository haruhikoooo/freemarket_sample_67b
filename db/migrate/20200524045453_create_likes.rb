class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :good_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
