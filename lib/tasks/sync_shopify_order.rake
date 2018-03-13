namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
  	Shop.all.each do |shop|
      Shop.set_session(shop)
  		shopify_order = ShopifyAPI::Order.all(params: {limit: 5, cancelled_at: nil})
      # shopify_order = ShopifyAPI::Order.all(params: {limit: 20})
  		shopify_order.each do |order|
        puts "=============================================="
        puts order.name
        puts shop.shopify_domain
        puts "=============================================="
  			Order.save_shopify_order(shop, order)
      end 
  	end
  end
end