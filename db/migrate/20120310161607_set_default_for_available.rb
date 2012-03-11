class SetDefaultForAvailable < ActiveRecord::Migration
  def up
    change_column :ads, :available, :boolean, :default => true
  end

  def down
  end
end
