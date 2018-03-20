namespace :order do
  desc 'Shopify sync missing orders'
  task update_shopify_tracking_url: :environment do
    Shop.where(:shop_type => "premium").each do |shop|
      Shop.set_session(shop)
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id)
      puts child_orders.count
      child_orders.each do |order|
        shopify_order = ShopifyAPI::Order.find(order.shopify_order_id)
        sleep(2)
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