class AddValueToProductTag < ActiveRecord::Migration[5.1]
  def change
    add_column :product_tags, :value, :string
  end
end
