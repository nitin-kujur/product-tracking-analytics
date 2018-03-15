namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    Shop.where(:shop_type => "premium") do |shop|
      child_orders = Order.where(:shop_id => shop.id).joins(:line_items).where("line_items.varaint_title like", "%Parent ID%")
      child_orders.each do |order|
        local_parent_id = shop.orders.joins(:line_items).first.variant_title.split(":")[1].strip
        parent_order = Order.where(:parent_order_flag => local_parent_id).first.shopify_order_id
        order.parent_order_id = parent_order
        order.save(:validate => false)
      end
    end
  end
end