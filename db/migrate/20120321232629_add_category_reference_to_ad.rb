class AddCategoryReferenceToAd < ActiveRecord::Migration
  def change
    add_column :ads, :category_id, :integer
    add_index :ads, :category_id
  end
end
