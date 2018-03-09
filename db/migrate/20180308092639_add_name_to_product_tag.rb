class AddNameToProductTag < ActiveRecord::Migration[5.1]
  def change
    add_column :product_tags, :name, :string
  end
end
