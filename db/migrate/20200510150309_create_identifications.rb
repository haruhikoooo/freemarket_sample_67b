class CreateIdentifications < ActiveRecord::Migration[5.2]
  def change
    create_table :identifications do |t|
      t.string :family_name, :string, null: false
      t.string :first_name, :string, null: false
      t.string :furigana_family, :string, null: false
      t.string :furigana_first, :string, null: false
      t.string :birthday, :date, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
