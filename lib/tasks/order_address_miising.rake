namespace :order do
  desc 'Shopify sync missing orders'
  task order_address_miising: :environment do
    Shop.all.each do |shop|
      Shop.set_session(shop)
      orders  = shop.orders.all
      orders.each do |order|
        if order.billing_address.nil? || order.shipping_address.nil?
          shopify_obj = ShopifyAPI::Order.find(order.shopify_order_id)
          if order.billing_address.nil?
            billing_address = Address.where(:first_name => shopify_obj.try(:billing_address).try(:first_name), :last_name => shopify_obj.try(:billing_address).try(:last_name), :address1 => shopify_obj.try(:billing_address).try(:address1), :phone => shopify_obj.try(:billing_address).try(:phone), :city => shopify_obj.try(:billing_address).try(:city), :zip => shopify_obj.try(:billing_address).try(:zip), :province => shopify_obj.try(:billing_address).try(:province), :country => shopify_obj.try(:billing_address).try(:country), :address2 => shopify_obj.try(:billing_address).try(:address2), :company => shopify_obj.try(:billing_address).try(:company), :name => shopify_obj.try(:billing_address).try(:name), :country_code => shopify_obj.try(:billing_address).try(:country_code), :province_code => shopify_obj.try(:billing_address).try(:province_code), :address_type => "Billing").first
            if billing_address.nil?
              billing_address = Address.new(:first_name => shopify_obj.billing_address.first_name, :last_name => shopify_obj.billing_address.last_name, :address1 => shopify_obj.billing_address.address1, :phone => shopify_obj.billing_address.phone, :city => shopify_obj.billing_address.city, :zip => shopify_obj.billing_address.zip, :province => shopify_obj.billing_address.province, :country => shopify_obj.billing_address.country, :address2 => shopify_obj.billing_address.address2, :company => shopify_obj.billing_address.company, :name => shopify_obj.billing_address.name, :country_code => shopify_obj.billing_address.country_code, :province_code => shopify_obj.billing_address.province_code, :address_type => "Billing" )
              billing_address.save
              order.billing_address_id = billing_address.id
              order.save(:validate => false)
            else
              order.billing_address_id = billing_address.id
              order.save(:validate => false)
            end
          end

          if order.shipping_address.nil?
            shipping_address = Address.new(:first_name => shopify_obj.shipping_address.first_name, :last_name => shopify_obj.shipping_address.last_name, :address1 => shopify_obj.shipping_address.address1, :phone => shopify_obj.shipping_address.phone, :city => shopify_obj.shipping_address.city, :zip => shopify_obj.shipping_address.zip, :province => shopify_obj.shipping_address.province, :country => shopify_obj.shipping_address.country, :address2 => shopify_obj.shipping_address.address2, :company => shopify_obj.shipping_address.company, :name => shopify_obj.shipping_address.name, :country_code => shopify_obj.shipping_address.country_code, :province_code => shopify_obj.shipping_address.province_code, :address_type => "Billing" )
            if shipping_address.nil?
              shipping_address.save
              order.shipping_address_id = shipping_address.id
              order.save(:validate => false)
            else
              order.shipping_address_id = shipping_address.id
              order.save(:validate => false)
            end
            sleep(2)
          end
        end
      end
    end
  end
end