class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :destination_family_name, null: false
      t.string :destination_first_name, null: false
      t.string :destination_furigana_family, null: false
      t.string :destination_furigana_first, null: false
      t.string :zipcode, null: false
      t.integer :prefecture_id, null: false, foreign_key: true
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :apartment_name, :string 
      t.string :tel
      t.timestamps
    end
  end
end
