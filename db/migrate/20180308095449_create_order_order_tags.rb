class CreateOrderOrderTags < ActiveRecord::Migration[5.1]
  def change
    create_table :order_order_tags do |t|
      t.integer :order_id
      t.integer :order_tag_id

      t.timestamps
    end
  end
end
