class LineItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |line_item|
      			csv << line_item.attributes.values_at(*column_names)
    		end
  		end
	end
end
