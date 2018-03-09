class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.string :shop_domain
      t.string :shop_private_api_keys
      t.string :shop_private_api_secret
      t.string :shop_private_api_password

      t.timestamps
    end
  end
end
