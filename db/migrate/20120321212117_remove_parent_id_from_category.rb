class RemoveParentIdFromCategory < ActiveRecord::Migration
  def up
    remove_column :categories, :parent_id
  end

  def down
    add_column :categories, :parent_id
  end
  
end
