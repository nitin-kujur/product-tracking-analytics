class ProductTag < ApplicationRecord
	has_many :product_product_tags
	has_many :products, through: :customer_customer_tags, dependent: :destroy

	def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |product_tag|
            csv << product_tag.attributes.values_at(*column_names)
        end
      end
  	end
end
