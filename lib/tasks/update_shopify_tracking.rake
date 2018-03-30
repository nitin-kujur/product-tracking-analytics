namespace :order do
  desc 'Shopify sync missing orders'
  task update_shopify_tracking: :environment do
    Shop.all.each do |shop|
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id)
      child_orders.each do |order|
        if order.shopify_tracking_id.present?
          puts order.shopify_tracking_id
          if order.shopify_tracking_id.include?("FEDEX")
            if order.shopify_tracking_id.split(" ")[1].nil?
              puts "+++++++++++++++++++++++++++++++++"
              puts order.shopify_tracking_id.split(" ")[1]
              puts "+++++++++++++++++++++++++++++++++"
              order.shopify_tracking_id = order.shopify_tracking_id.split(" ")[1]
            else
              puts "-------------------------------------"
              puts order.shopify_tracking_id.split(" ")[1]
              puts "-------------------------------------"
              order.shopify_tracking_id = order.shopify_tracking_id.split("#")[1]
            end
          else
            order.shopify_tracking_id = order.shopify_tracking_id
          end
          if order.save(:validate => false)
            puts "---------------------------"
            puts "Order save successfully"
            puts "---------------------------"
          else
            puts "---------------------------"
            puts order.errors.full_messages
            puts "---------------------------"
          end
        end
      end
    end
  end
end