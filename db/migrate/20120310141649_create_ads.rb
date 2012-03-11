class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :description
      t.string :image_url
      t.string :price
      t.boolean :available

      t.timestamps
    end
  end
end
