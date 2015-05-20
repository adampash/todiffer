class AddVersionAddedAtToText < ActiveRecord::Migration
  def change
    add_column :texts, :version_added_at, :datetime
  end
end
