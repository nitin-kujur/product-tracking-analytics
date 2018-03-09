namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
  	Shop.all.each do |shop|
  		Shop.set_session(shop)
  		shopify_order = ShopifyAPI::Order.all(params: {limit: 10, :processed_at_min => Date.today - 1, :processed_at_max => Date.today})
  		shopify_order.each do |order|
  			Order.save_shopify_order(shop, order)
      end 
  	end
  end
end