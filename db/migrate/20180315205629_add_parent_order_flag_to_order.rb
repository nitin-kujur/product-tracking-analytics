class AddParentOrderFlagToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :parent_order_flag, :string
  end
end
