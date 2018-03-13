class Customer < ApplicationRecord
	belongs_to :shop
	has_many :customer_customer_tags
	has_many :customer_tags, through: :customer_customer_tags, source: :customer_tag, dependent: :destroy

	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |customer|
      			csv << customer.attributes.values_at(*column_names)
    		end
  		end
	end
end
