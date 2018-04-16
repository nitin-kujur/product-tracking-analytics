namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    Shop.where(:shopify_domain => "pepsidewmixology.myshopify.com").each do |shop|
      Shop.set_session(shop)
      order_count = 2500
      pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
      orders = []
      (1..pages).each { |page| orders << ShopifyAPI::Order.find(:all, params: { page: page, status: 'any', limit: 250}) }
      orders.flatten!
      orders.each do |order|
        puts "------------------------"
        puts order.name
        puts "------------------------"
        unless order.name == "SWP1817" || order.name == "SWP1816" || order.name == "SWP1809"
          Order.save_shopify_order(shop, order)
        end
      end 
    end
  end
end 