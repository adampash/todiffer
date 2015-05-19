class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :url, null: false
      t.datetime :last_check, null: false
      t.datetime :check_at, null: false
      t.integer :submitted_by_id, null: false
      t.string :selector
      t.string :md5, null: false

      t.timestamps null: false
    end
  end
end
