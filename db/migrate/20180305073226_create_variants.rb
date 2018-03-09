class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.string :product_id
      t.string :shopify_product_id
      t.string :title
      t.string :sku
      t.string :inventory_policy
      t.string :position
      t.integer :inventory_quantity
      t.string :source

      t.timestamps
    end
  end
end
