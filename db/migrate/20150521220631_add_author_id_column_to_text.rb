class AddAuthorIdColumnToText < ActiveRecord::Migration
  def change
    add_column :texts, :author_id, :integer
    add_index :texts, :author_id
  end
end
