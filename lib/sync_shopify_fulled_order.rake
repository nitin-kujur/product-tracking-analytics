namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_fulled_order: :environment do
    Shop.all.each do |shop|
      Shop.set_session(shop)
      order_count = 2500
      pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
      orders  = shop.orders.where(:fulfillment_status => 'fulfilled').where(:tracking_url => nil)
      orders.each do |order|
        shopify_order = ShopifyAPI::Order.find(order.shopify_order_id)
        Order.save_shopify_order(shop, shopify_order)
      end
    end
  end
end