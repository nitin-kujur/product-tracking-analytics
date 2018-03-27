class AddOrderTypeToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_type, :string
  end
end
