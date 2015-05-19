class CreateWatchedTexts < ActiveRecord::Migration
  def change
    create_table :watched_texts do |t|
      t.integer :user_id, null: false
      t.integer :text_id, null: false
      t.boolean :notify, null: false, default: false

      t.timestamps null: false
    end
  end
end
