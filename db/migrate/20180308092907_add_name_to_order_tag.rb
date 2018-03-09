class AddNameToOrderTag < ActiveRecord::Migration[5.1]
  def change
    add_column :order_tags, :name, :string
  end
end
