class AddColorToAds < ActiveRecord::Migration
  def change
    add_column :ads, :color, :string
  end
end
