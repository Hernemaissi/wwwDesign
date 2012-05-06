class ChangeDataTypeForAdPrice < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.change :price, :decimal
    end
  end

  def self.down
    change_table :ads do |t|
      t.change :count, :string
    end
  end
end