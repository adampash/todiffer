class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.text :text, null: false
      t.string :md5, null: false
      t.string :title, default: ''
      t.integer :text_id, null: false

      t.timestamps null: false
    end
  end
end
