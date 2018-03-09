class AddValueToOrderTag < ActiveRecord::Migration[5.1]
  def change
    add_column :order_tags, :value, :string
  end
end
