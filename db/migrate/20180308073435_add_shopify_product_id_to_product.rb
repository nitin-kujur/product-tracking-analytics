class AddShopifyProductIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :shopify_product_id, :string
  end
end
