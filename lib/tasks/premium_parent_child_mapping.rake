namespace :order do
  desc 'Shopify sync missing orders'
  task premium_parent_child_mapping: :environment do
    Shop.all.each do |shop|
      
    end
  end
end