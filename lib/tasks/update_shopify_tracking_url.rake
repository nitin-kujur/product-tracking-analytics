namespace :order do
  desc 'Shopify sync missing orders'
  task update_shopify_tracking_url: :environment do
    Shop.where(:shop_type => "premium").each do |shop|
      Shop.set_session(shop)
      order_count = 500
      pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
      orders = []
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id)
      puts child_orders.count
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
        child_orders.each do |order|
        shopify_order = ShopifyAPI::Order.find(order.shopify_order_id)
        if shopify_order.fulfillments.present?
          order.tracking_url = shopify_order.fulfillments.first.tracking_url
          if shopify_order.fulfillments.last.shipment_status == "delivered"
            order.shipped_date = shopify_order.fulfillments.last.updated_at
          end
        end
        order.save
        end
      end
    end
  end
end