class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.integer :shop_id
      t.string :first_name
      t.string :last_name
      t.string :shopify_customer_id
      t.string :email
      t.float :total_spent
      t.integer :orders_count

      t.timestamps
    end
  end
end
