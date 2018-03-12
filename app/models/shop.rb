class Shop < ApplicationRecord
	include ShopifyApp::Shop
  include ShopifyApp::SessionStorage
  has_many :orders
	has_many :products
	has_many :customers

	def self.set_session(shop)
    	ShopifyAPI::Base.clear_session
    	ShopifyAPI::Base.site = "https://#{shop.shop_private_api_keys}:#{shop.shop_private_api_password}@#{shop.shop_domain}/admin"
    	ShopifyAPI::Session.setup({ api_key: shop.shop_private_api_keys, secret: shop.shop_private_api_secret })
  	end

  	def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |shop|
            csv << shop.attributes.values_at(*column_names)
        end
      end
  	end
end
