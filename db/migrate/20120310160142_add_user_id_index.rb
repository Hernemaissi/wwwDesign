class AddUserIdIndex < ActiveRecord::Migration
  def up
    add_index :ads, [:user_id, :created_at]
  end

  def down
  end
end
