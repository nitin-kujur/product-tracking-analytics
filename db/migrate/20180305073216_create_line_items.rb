class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :shopify_vaiant_id
      t.integer :order_id
      t.string :shopify_line_item_id
      t.string :variant_id
      t.text :title
      t.integer :quantity
      t.decimal :price
      t.string :sku
      t.string :fulfillment_service
      t.string :shopify_product_id
      t.boolean :requires_shipping
      t.json :properties, array: true
      t.integer :fulfillable_quantity
      t.decimal :total_discount
      t.string :fulfillment_status
      t.json :origin_location
      t.json :destination_location

      t.timestamps
    end
  end
end
