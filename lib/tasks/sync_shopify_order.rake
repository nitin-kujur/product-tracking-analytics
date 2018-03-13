namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    CYCLE = 0.5     # You can average 2 calls per second
    shopify_orders_count = 20
    nb_pages      = (shopify_orders_count / 250.0).ceil
    start_time = Time.now
    1.upto(nb_pages) do |page|
  	  Shop.all.each do |shop|
          Shop.set_session(shop)
  		    shopify_order = ShopifyAPI::Order.all(params: {limit: 5, cancelled_at: nil})
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
end