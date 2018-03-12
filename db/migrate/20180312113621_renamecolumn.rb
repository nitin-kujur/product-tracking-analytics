class Renamecolumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :shops, :shop_domain, :shopify_domain
  end
end
