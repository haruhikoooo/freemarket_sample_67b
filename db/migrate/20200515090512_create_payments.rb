class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :card_number, null: false, unique: true
      t.string :expiration_data_month, null: false
      t.string :expiration_data_year, null: false
      t.string :security_code, null: false
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
