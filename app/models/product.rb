class Product < ApplicationRecord
	has_many :variants, dependent: :destroy
	has_many :product_tags, dependent: :destroy
	has_many :order_products, dependent: :destroy, dependent: :destroy
	has_many :orders, through: :order_products, dependent: :destroy
	has_many :product_product_tags, dependent: :destroy
	has_many :product_tags, through: :product_product_tags, source: :product_tag, dependent: :destroy

	def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |product|
            csv << product.attributes.values_at(*column_names)
        end
      end
  	end
end
