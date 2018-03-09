class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :shop_id
      t.integer :Number_of_orders
      t.string :title
      t.string :product_type
      t.string :vendor
      t.string :handle

      t.timestamps
    end
  end
end
