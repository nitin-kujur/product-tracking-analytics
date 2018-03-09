class CreateProductProductTags < ActiveRecord::Migration[5.1]
  def change
    create_table :product_product_tags do |t|
      t.integer :product_id
      t.integer :product_tag_id

      t.timestamps
    end
  end
end
