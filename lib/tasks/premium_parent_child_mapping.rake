namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    start_date = Date.today - 15
    end_date = Date.today
    Shop.where(:shopify_domain => "shophydration.myshopify.com").each do |shop|
      puts "I am entered into shop"
      child_orders = Order.all.where(:shop_id => shop.id).joins(:line_items).where("line_items.variant_title like ?", "%Parent ID%")
      child_orders.each do |order|
        local_parent_id = order.line_items.first.variant_title.split(":")[1].strip
        puts "--------------------------------"
        puts local_parent_id
        puts "--------------------------------"
        parent_order = Order.where(:parent_order_flag => local_parent_id).try(:first)
        puts "++++++++++++++++++++++++++++"
        puts parent_order
        puts "++++++++++++++++++++++++++++"
        puts parent_order.try(:shopify_order_id)
        order.parent_order_id = parent_order.try(:shopify_order_id)
        order.order_type = "Child"
        parent_order.order_type = "Parent" unless parent_order.nil?
        parent_order.save(:validate => false) unless parent_order.nil?
        if order.save(:validate => false)
          puts "------------- I am at save --------------"
        else
          puts order.errors.inspect
        end
      end
    end
  end
end