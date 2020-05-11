class CreateIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :identifications do |t|
      t.string :family_name, null: false
      t.string :first_name, null: false
      t.string :furigana_family, null: false
      t.string :furigana_first, null: false
      t.date :birthday, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
