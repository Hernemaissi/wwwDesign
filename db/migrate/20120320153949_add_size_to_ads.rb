class AddSizeToAds < ActiveRecord::Migration
  def change
    add_column :ads, :size, :string
  end
end
