namespace :order do
  desc 'Shopify sync missing orders'
  task update_shopify_tracking: :environment do
    Shop.all.each do |shop|
      puts "I am entered into shop"
      child_orders = Order.where(:shop_id => shop.id)
      child_orders.each do |order|
        if order.shopify_tracking_id.present?
          puts order.shopify_tracking_id
          if order.shopify_tracking_id.include?("UPS")
            if order.shopify_tracking_id.split(" ")[1].nil?
              order.shopify_tracking_id = order.shopify_tracking_id.split(" ")[1]
              puts "+++++++++++++++++++++++++++++++++"
              puts order.shopify_tracking_id.split(" ")[1]
              puts "+++++++++++++++++++++++++++++++++"
            else
              order.shopify_tracking_id = order.shopify_tracking_id.split("#")[1]
              puts "-------------------------------------"
              puts order.shopify_tracking_id.split(" ")[1]
              puts "-------------------------------------"
            end
          else
            order.shopify_tracking_id = order.shopify_tracking_id
          end
        end
        order.save
      end
    end
  end
end