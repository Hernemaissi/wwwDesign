class CreateTableAdsParts < ActiveRecord::Migration
  def change
    create_table :ads_parts, :id => false do |t|
      t.integer :ad_id
      t.integer :part_id
    end
  end
end
