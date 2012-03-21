class AddConditionToAds < ActiveRecord::Migration
  def change
    add_column :ads, :condition, :string
  end
end
