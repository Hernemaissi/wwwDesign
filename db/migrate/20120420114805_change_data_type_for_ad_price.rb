class ChangeDataTypeForAdPrice < ActiveRecord::Migration
  def self.up
    rename_column :ads, :price, :price_string
    add_column :ads, :price, :decimal
  
    Ad.reset_column_information
    Ad.find_each { |a| a.update_attribute(:price, a.price_string) } 
    remove_column :ads, :price_string
  end


  def self.down
    rename_column :ads, :price, :price_decimal
    add_column :ads, :price, :string
  
    Ad.reset_column_information
    Ad.find_each { |a| a.update_attribute(:price, a.price_decimal) } 
    remove_column :ads, :price_decimal
  end
end