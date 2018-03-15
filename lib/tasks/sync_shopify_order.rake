namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    Shop.all.each do |shop|
      if shop.shopify_domain == "pepsinba.myshopify.com"
        Shop.set_session(shop)
        order_count = 300
        pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
        orders = []
        (1..pages).each { |page| orders << ShopifyAPI::Order.find(:all, params: { page: page, status: 'any', limit: 250}) }
        orders.flatten!
        orders.each do |order|
          # local_order = Order.where(:order_number => order.name).first
          # if local_order.nil?
            puts "------------------------"
            puts order.name
            puts "------------------------"
            Order.save_shopify_order(shop, order)
          # end
        end
      end
    end
  end
end