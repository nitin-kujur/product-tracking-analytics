class AddShopifyVariantIdToVariant < ActiveRecord::Migration[5.1]
  def change
    add_column :variants, :shopify_variant_id, :string
  end
end
