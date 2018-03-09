class Address < ApplicationRecord
	has_one :billing_orders, :class_name => "Order", 
    :foreign_key => "billing_address_id" 
  	has_one :shipping_orders, :class_name => "Order", 
    :foreign_key => "shipping_address_id"

    def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |address|
      			csv << address.attributes.values_at(*column_names)
    		end
  		end
	end
end
