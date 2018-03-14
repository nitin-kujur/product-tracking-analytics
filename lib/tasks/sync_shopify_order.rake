# namespace :order do
#   desc 'Shopify sync missing orders'
#   task sync_shopify_order: :environment do
#     CYCLE = 0.5     # You can average 2 calls per second
#     Shop.all.each do |shop|
      
#       shopify_orders_count = 1200
#       nb_pages      = (shopify_orders_count / 250.0).ceil
#       start_time = Time.now
      
#       1.upto(nb_pages) do |page|
#         unless page == 1
#           stop_time = Time.now
#           puts "Last batch processing started at #{start_time.strftime('%I:%M%p')}"
#           puts "The time is now #{stop_time.strftime('%I:%M%p')}"
#           processing_duration = stop_time - start_time
#           puts "The processing lasted #{processing_duration.to_i} seconds."
#           wait_time = (CYCLE - processing_duration).ceil
#           puts "We have to wait #{wait_time} seconds then we will resume."
#           sleep wait_time if wait_time > 0
#           start_time = Time.now
#         end
#         puts "Doing page #{page}/#{nb_pages}..."
#         Shop.set_session(shop)
#         shopify_orders_count = ShopifyAPI::Order.count
#         shopify_page = 1
#         shopify_order = ShopifyAPI::Order.find(:all, params: {status: :any, limit: 250, page: shopify_page})
#         max_result_count = shopify_order.nil? ? 0 : shopify_order.count
#         while max_result_count == 250
#           shopify_page = shopify_page + 1
#           temp_shop_orders = ShopifyAPI::Order.find(:all, params: {limit: 250, page: shopify_page})
#           shopify_order = shopify_order + temp_shop_orders
#           max_result_count = temp_shop_orders.count
#         end
#         shopify_order
#         shopify_order.each do |order|
#           puts "=============================================="
#           puts order.name
#           puts shop.shopify_domain
#           puts "=============================================="
#           Order.save_shopify_order(shop, order)
#         end
#       end
#     end
#   end
# end

namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    Shop.all.each do |shop|
      Shop.set_session(shop)
      order_count = ShopifyAPI::Order.count
      pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
      orders = []
      (1..pages).each { |page| orders << ShopifyAPI::Order.find(:all, params: { page: page, status: 'any', limit: 250}) }
      orders.flatten!
      orders.each do |order|
        local_order = Order.where(:order_number => order.name).first
        if local_order.nil?
          Order.save_shopify_order(shop, order)
        end
      end
    end
  end
end