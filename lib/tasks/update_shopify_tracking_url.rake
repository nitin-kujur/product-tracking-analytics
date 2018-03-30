namespace :order do
  desc 'Shopify sync missing orders'
  task update_shopify_tracking_url: :environment do
    Shop.all.each do |shop|
      Shop.set_session(shop)
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id)
      puts child_orders.count
      child_orders.each do |order|
        sleep(2)
        shopify_order = ShopifyAPI::Order.find(order.shopify_order_id)
        if shopify_order.fulfillments.present?
          if shopify_obj.fulfillments.first.first.tracking_number.present?
            if shopify_obj.fulfillments.first.first.tracking_number.include?("UPS") == true
              if shopify_obj.fulfillments.first.first.tracking_number.split(" ")[1].nil?
                order.shopify_tracking_id = shopify_obj.fulfillments.first.first.tracking_number.split(" ")[1]
              else
                order.shopify_tracking_id = shopify_obj.fulfillments.first.first.tracking_number.split("#")[1]
              end
            else
              order.shopify_tracking_id = shopify_obj.fulfillments.first.first.tracking_number
            end
          end
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