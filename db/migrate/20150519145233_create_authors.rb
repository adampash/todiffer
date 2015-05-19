class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :twitter
      t.string :facebook
      t.string :google_plus
      t.string :name

      t.timestamps null: false
    end
  end
end
