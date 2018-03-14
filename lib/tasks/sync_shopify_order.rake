namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    CYCLE = 0.5     # You can average 2 calls per second
    Shop.all.each do |shop|
      
      shopify_orders_count = 1200
      nb_pages      = (shopify_orders_count / 250.0).ceil
      start_time = Time.now
      
      1.upto(nb_pages) do |page|
        unless page == 1
          stop_time = Time.now
          puts "Last batch processing started at #{start_time.strftime('%I:%M%p')}"
          puts "The time is now #{stop_time.strftime('%I:%M%p')}"
          processing_duration = stop_time - start_time
          puts "The processing lasted #{processing_duration.to_i} seconds."
          wait_time = (CYCLE - processing_duration).ceil
          puts "We have to wait #{wait_time} seconds then we will resume."
          sleep wait_time if wait_time > 0
          start_time = Time.now
        end
        puts "Doing page #{page}/#{nb_pages}..."
        Shop.set_session(shop)
        shopify_orders_count = ShopifyAPI::Order.count
        shopify_order = ShopifyAPI::Order.all(params: {limit: 3})
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