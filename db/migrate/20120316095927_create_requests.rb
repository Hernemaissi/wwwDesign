class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :ad_id

      t.timestamps
    end
    add_index :requests, :sender_id
    add_index :requests, :ad_id
    add_index :requests, [:sender_id, :ad_id], :unique => true
  end
end
