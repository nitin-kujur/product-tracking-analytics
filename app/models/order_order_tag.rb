class OrderOrderTag < ApplicationRecord
	belongs_to :order
	belongs_to :order_tag
	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |customer|
      			csv << customer.attributes.values_at(*column_names)
    		end
  		end
	end
end
