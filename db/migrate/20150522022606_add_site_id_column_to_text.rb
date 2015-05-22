class AddSiteIdColumnToText < ActiveRecord::Migration
  def change
    add_column :texts, :site_id, :integer
    add_index :texts, :site_id
  end
end
