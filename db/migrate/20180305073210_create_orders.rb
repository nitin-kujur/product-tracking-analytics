class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :shop_id
      t.integer :customer_id
      t.string :shopify_order_id
      t.string :email
      t.datetime :closed_at
      t.datetime :shopify_created_at
      t.datetime :shopify_updated_at
      t.integer :number
      t.decimal :total_price
      t.decimal :subtotal_price
      t.float :total_weight
      t.float :total_tax
      t.string :financial_status
      t.decimal :total_line_items_price
      t.datetime :cancelled_at
      t.text :cancel_reason
      t.integer :user_id
      t.datetime :processed_at
      t.string :order_number
      t.string :fulfillment_status
      t.string :contact_email
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :shopify_customer_id
      t.string :customer_email
      t.string :order_region
      t.datetime :deleted_at
      t.string :discount_codes
      t.integer :deleted_by
      t.string :client_details
      t.string :parent_order_id
      t.string :parent_customer_id
      t.string :shopify_tracking_id
      t.integer :billing_address_id
      t.integer :shipping_address_id

      t.timestamps
    end
  end
end
