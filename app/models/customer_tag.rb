class CustomerTag < ApplicationRecord
	has_many :customer_customer_tags
	has_many :customers, through: :customer_customer_tags, dependent: :destroy
	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |customer_tag|
      			csv << customer_tag.attributes.values_at(*column_names)
    		end
  		end
	end
end
