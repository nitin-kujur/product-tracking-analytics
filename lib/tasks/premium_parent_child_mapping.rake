namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    # Shop.where(:shop_type => "premium") do |shop|
      shop = Shop.where(:shopify_domain => "pepsinba.myshopify.com").first
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id).joins(:line_items).where("line_items.variant_title like ?", "%Parent ID%")
      puts child_orders.count
      child_orders.each do |order|
        local_parent_id = shop.orders.joins(:line_items).first.variant_title.split(":")[1].strip
        puts local_parent_id
        parent_order = Order.where(:parent_order_flag => local_parent_id).first.shopify_order_id
        puts parent_order
        order.parent_order_id = parent_order
        if order.save(:validate => false)
          puts "------------- I am at save --------------"
        else
          puts order.errors.inspect
        end
      end
    # end
  end
end