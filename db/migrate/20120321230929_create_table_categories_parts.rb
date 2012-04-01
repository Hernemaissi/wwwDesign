class CreateTableCategoriesParts < ActiveRecord::Migration
  def change
    create_table :categories_parts, :id => false do |t|
      t.integer :category_id
      t.integer :part_id
    end
  end
end
