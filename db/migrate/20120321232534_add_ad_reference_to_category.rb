class AddAdReferenceToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :ad_id, :integer
    add_index :categories, :ad_id
  end
end

