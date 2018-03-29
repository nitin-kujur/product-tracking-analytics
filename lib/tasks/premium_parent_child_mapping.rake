namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    start_date = Date.today - 3
    end_date = Date.today
    Shop.where(:shop_type => "premium").each do |shop|
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id).where("DATE(created_at) BETWEEN ? AND ?", "#{start_date}","#{end_date}").joins(:line_items).where("line_items.variant_title like ?", "%Parent ID%")
      puts child_orders.count
      child_orders.each do |order|
        local_parent_id = order.line_items.first.variant_title.split(":")[1].strip
        puts local_parent_id
        parent_order = Order.where(:parent_order_flag => local_parent_id).try(:first)
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