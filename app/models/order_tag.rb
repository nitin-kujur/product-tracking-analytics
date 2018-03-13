class OrderTag < ApplicationRecord
	has_many :order_order_tags
	has_many :orders, through: :order_order_tags, dependent: :destroy

	def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |order_tag|
            csv << order_tag.attributes.values_at(*column_names)
        end
      end
  	end
end
