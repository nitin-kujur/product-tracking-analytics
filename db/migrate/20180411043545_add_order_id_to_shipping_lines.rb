class AddOrderIdToShippingLines < ActiveRecord::Migration[5.1]
  def change
    add_column :shipping_lines, :order_id, :integer
  end
end
