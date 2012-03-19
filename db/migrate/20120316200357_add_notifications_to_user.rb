class AddNotificationsToUser < ActiveRecord::Migration
  def change
    add_column :users, :notifications, :integer, :default => 0
  end
end
