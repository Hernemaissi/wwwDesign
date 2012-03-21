class AddMaterialToAds < ActiveRecord::Migration
  def change
    add_column :ads, :material, :string
  end
end
