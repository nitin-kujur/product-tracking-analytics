class AddShopTypeToShop < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :shop_type, :string
  end
end
