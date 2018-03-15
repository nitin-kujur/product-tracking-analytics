namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    Shop.where(:shop_type => "premium") do |shop|
      child_orders = shop.orders.joins(:line_items).where("line_items.varaint_title like", "%Parent ID%")
      parent_orders = shop.orders.where(:financial_status => "paid" || "pending")
      child_orders.each do |order|
        local_parent_id = shop.orders.joins(:line_items).first.variant_title.split(":")[1].strip
        parent_orders.each do |parent_order|
          parent_order.properties.each do |prop|
            if prop.value == variant_title
              order.parent_order_id = parent_order.shopify_order_id
              order.save
            end
          end
        end
      end
    end
  end
end