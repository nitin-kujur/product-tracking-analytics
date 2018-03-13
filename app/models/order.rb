class Order < ApplicationRecord
	has_many :line_items, dependent: :destroy
	belongs_to :customer, dependent: :destroy
	has_many :order_products
	has_many :products, through: :order_products, dependent: :destroy
	has_many :order_order_tags
	has_many :order_tags, through: :order_order_tags, dependent: :destroy
	belongs_to :billing_address, :class_name => 'Address', :foreign_key => "billing_address_id", dependent: :destroy
  belongs_to :shipping_address, :class_name => 'Address', :foreign_key => "shipping_address_id", dependent: :destroy
  # belongs_to :parent_order, :class_name => 'Order', primary_key: :parent_order_id
  # has_many :child_orders, :class_name => 'Order', primary_key: :child_order_id, foreign_key: :parent_order_id

    def self.collect_customer_region(tags_str)
    	customer_tags = tags_str.split(",")
    	customer_tags = customer_tags.collect(&:strip)
    	customer_tag = customer_tags
  	end

    def self.save_shopify_order(shop, shopify_obj)
    	@customer = Customer.where(:email => shopify_obj.try(:customer).try(:email)).first
    	puts @customer.nil?
    	puts @customer.inspect
    	if @customer.nil?
    		@customer = Customer.new(:shop_id => shop.id, :first_name => shopify_obj.try(:customer).try(:first_name), :last_name => shopify_obj.try(:customer).try(:last_name), :shopify_customer_id => shopify_obj.try(:customer).try(:id), :email => shopify_obj.try(:customer).try(:email))
    		@customer.save
    		puts @customer.inspect
    	end
      unless shopify_obj.try(:customer).nil?
    	 shopify_obj.customer.tags.split(",").each do |c_t|
    	 	customer_tag = CustomerTag.where(:name => c_t.split(":")[0].try(:strip), :value => c_t.split(":")[1].try(:strip)).first
    		if customer_tag.nil?
    			customer_t = CustomerTag.new(
    				:name => c_t.split(":")[0].try(:strip),
        		:value => c_t.split(":")[1].try(:strip)
    				)
    			customer_t.customer_customer_tags.build(
  					:customer_id => @customer.id
  				)
  				customer_t.save
    		else
    			customer_tag.customer_customer_tags.build(
  					:customer_id => @customer.id,
  					:customer_tag_id => customer_tag.id
  				)
    		end
    	end
      end
    	@order = Order.new
    	order_tags = Order.collect_customer_region(shopify_obj.tags)
    	order_tags = order_tags.select{|x| /ParentId:/ =~ x}
    	parent_id_tag = order_tags.first
    	parent_id_arr = parent_id_tag.split(":") if parent_id_tag
    	parent_id = parent_id_arr[1] if parent_id_arr
    	@order.shop_id = shop.id
  		@order.customer_id = @customer.id
  		@order.shopify_order_id = shopify_obj.id
  		@order.email = shopify_obj.try(:customer).try(:email)
  		@order.closed_at = shopify_obj.closed_at
  		@order.shopify_created_at = shopify_obj.processed_at
  		@order.shopify_updated_at = shopify_obj.updated_at
  		@order.number = shopify_obj.name
  		@order.total_price = shopify_obj.total_price
  		@order.subtotal_price = shopify_obj.subtotal_price
  		@order.total_weight = shopify_obj.total_weight
  		@order.total_tax = shopify_obj.total_tax
  		@order.financial_status = shopify_obj.financial_status
  		@order.total_line_items_price = shopify_obj.total_line_items_price
  		@order.cancelled_at = shopify_obj.cancelled_at
  		@order.cancel_reason = shopify_obj.cancel_reason
  		@order.user_id = shopify_obj.user_id
  		@order.processed_at = shopify_obj.processed_at
  		@order.order_number = shopify_obj.name
  		@order.fulfillment_status = shopify_obj.fulfillment_status
  		@order.contact_email = shopify_obj.contact_email
  		@order.shopify_customer_id = shopify_obj.try(:customer).try(:id)
  		@order.customer_email = shopify_obj.try(:customer).try(:email)
  		@order.order_region = shopify_obj.tags.split(",").select{|x| /Region/ =~ x}
  		# @order.deleted_at = shopify_obj.deleted_at
  		@order.discount_codes = shopify_obj.discount_codes
  		# @order.deleted_by = shopify_obj.deleted_by
  		# @order.client_details = shopify_obj.client_details
  		@order.parent_order_id = parent_id
  		# @order.parent_customer_id = shopify_obj.parent_customer_id
      sum = 0
      shopify_obj.line_items.each do |item|
        sum = sum + ( item.price.to_f + item.quantity)
      end
      @order.amount = sum
  		@order.shopify_tracking_id = shopify_obj.fulfillments.first.tracking_number if shopify_obj.fulfillments.present?
      
  		shopify_obj.tags.split(",").each do |order_tag|
  			order_t = OrderTag.where(:name => order_tag.split(":")[0].try(:strip), :value => order_tag.split(":")[1].try(:strip)).first
  			if order_t.nil?
  				order_t = OrderTag.create(
  					:name => order_tag.split(":")[0].try(:strip),
        		:value => order_tag.split(":")[1].try(:strip)
  				)
  				@order.order_order_tags.build(
  					:order_tag_id => order_t.id
  				)
  			else
  				@order.order_order_tags.build(
  					:order_tag_id => order_t.id
  				)
  			end
  		end
  		if shopify_obj.line_items.present?
        	shopify_obj.line_items.each do |l|
        		product = Product.where(:shopify_product_id => l.product_id).last
        		if product.nil?
              if l.product_id.nil?
               shopify_product = nil 
              else
        			 shopify_product = ShopifyAPI::Product.find(l.product_id)
              end

        		unless shopify_product.nil?	

              product = Product.new(
        				:shopify_product_id => shopify_product.id,
        				:shop_id => shop.id, 
        				# :number_of_orders => shopify_product.number_of_orders, 
        				:title => shopify_product.title, 
        				:product_type => shopify_product.product_type, 
        				:vendor => shopify_product.vendor, 
        				:handle => shopify_product.handle, 
        			)
        			shopify_product.variants.each do |variant|
        				shopify_variant = ShopifyAPI::Variant.find(variant.id)
        				variant = Variant.where(:shopify_variant_id => variant.id).first
        				if variant.nil?
        					product.variants.build(
        						:shopify_product_id => shopify_product.id, 
        						:title => shopify_variant.title, 
        						:sku => shopify_variant.sku, 
        						:inventory_policy => shopify_variant.inventory_policy, 
        						:position => shopify_variant.position, 
        						:inventory_quantity => shopify_variant.inventory_quantity, 
        						:source => nil,
        						:shopify_variant_id => shopify_variant.id
        					)
        				end
        			end
        			product.save
        			@order.order_products.build(:product_id => product.id)
        			shopify_product.tags.split(",").each do |p_t|
        				product_tag = ProductTag.where(:name => p_t.split(":")[0].try(:strip), :value => p_t.split(":")[1].try(:strip)).first
        				if product_tag.nil?
        					product_t = ProductTag.new(
        						:name => p_t.split(":")[0].try(:strip),
        						:value => p_t.split(":")[1].try(:strip)
        						)
        					product_t.product_product_tags.build(
        					:product_id => product.id
        					)
        					product_t.save
						else
							ProductProductTag.create(
        						:product_id => product.id,
        						:product_tag_id => product_tag.id
        					)
						end	
            end
					end

        		end
          		@order.line_items.build(:shopify_line_item_id => l.id,
          			:variant_id => l.variant_id,
          			:title => l.title,
          			:quantity => l.quantity,
          			:price => l.price,
          			:sku => l.sku,
          			:fulfillment_service => l.fulfillment_service,
          			:product_id => product.try(:id),
          			:requires_shipping => l.requires_shipping,
          			:properties => l.properties.map(&:attributes),
          			:fulfillable_quantity => l.fulfillable_quantity,
          			:total_discount => l.total_discount,
          			:fulfillment_status => l.fulfillment_status,
          			:destination_location => l.try(:destination_location).try(:attributes),
          			:origin_location => l.try(:origin_location).try(:attributes)
          		)
        	end
      	end  
      	if shopify_obj.try(:billing_address).present?  
      		billing_address = Address.where(:first_name => shopify_obj.try(:billing_address).try(:first_name), :last_name => shopify_obj.try(:billing_address).try(:last_name), :address1 => shopify_obj.try(:billing_address).try(:address1), :phone => shopify_obj.try(:billing_address).try(:phone), :city => shopify_obj.try(:billing_address).try(:city), :zip => shopify_obj.try(:billing_address).try(:zip), :province => shopify_obj.try(:billing_address).try(:province), :country => shopify_obj.try(:billing_address).try(:country), :address2 => shopify_obj.try(:billing_address).try(:address2), :company => shopify_obj.try(:billing_address).try(:company), :name => shopify_obj.try(:billing_address).try(:name), :country_code => shopify_obj.try(:billing_address).try(:country_code), :province_code => shopify_obj.try(:billing_address).try(:province_code), :address_type => "Billing")
			unless billing_address.present?	
        		billing_address = Address.create(:first_name => shopify_obj.billing_address.first_name,
        		:last_name => shopify_obj.billing_address.last_name,
        		:address1 => shopify_obj.billing_address.address1,
        		:phone => shopify_obj.billing_address.phone,
        		:city => shopify_obj.billing_address.city,
        		:zip => shopify_obj.billing_address.zip,
        		:province => shopify_obj.billing_address.province,
        		:country => shopify_obj.billing_address.country,
        		:address2 => shopify_obj.billing_address.address2,
        		:company => shopify_obj.billing_address.company,
        		:name => shopify_obj.billing_address.name,
        		:country_code => shopify_obj.billing_address.country_code,
        		:province_code => shopify_obj.billing_address.province_code,
        		:address_type => "Billing"
        		)
        	end
      	end  

      	if shopify_obj.try(:shipping_address).present? 
      		shipping_address = Address.where(:first_name => shopify_obj.try(:shipping_address).try(:first_name), :last_name => shopify_obj.try(:shipping_address).try(:last_name), :address1 => shopify_obj.try(:shipping_address).try(:address1), :phone => shopify_obj.try(:shipping_address).try(:phone), :city => shopify_obj.try(:shipping_address).try(:city), :zip => shopify_obj.try(:shipping_address).try(:zip), :province => shopify_obj.try(:shipping_address).try(:province), :country => shopify_obj.try(:shipping_address).try(:country), :address2 => shopify_obj.try(:shipping_address).try(:address2), :company => shopify_obj.try(:shipping_address).try(:company), :name => shopify_obj.try(:shipping_address).try(:name), :country_code => shopify_obj.try(:shipping_address).try(:country_code), :province_code => shopify_obj.try(:shipping_address).try(:province_code), :address_type => "Shipping")
      		unless shipping_address.present?
      			shipping_address = Address.create(
        		:first_name => shopify_obj.shipping_address.first_name,
        		:last_name => shopify_obj.shipping_address.last_name,
        		:address1 => shopify_obj.shipping_address.address1,
        		:phone => shopify_obj.shipping_address.phone,
        		:city => shopify_obj.shipping_address.city,
        		:zip => shopify_obj.shipping_address.zip,
        		:province => shopify_obj.shipping_address.province,
        		:country => shopify_obj.shipping_address.country,
        		:address2 => shopify_obj.shipping_address.address2,
        		:company => shopify_obj.shipping_address.company,
        		:name => shopify_obj.shipping_address.name,
        		:country_code => shopify_obj.shipping_address.country_code,
        		:province_code => shopify_obj.shipping_address.province_code,
        		:address_type => "Shipping"
        		)
        	end
      	end  
    	@order.billing_address_id = billing_address.try(:id) if shopify_obj.try(:billing_address).present? 
    	@order.shipping_address_id = shipping_address.try(:id) if shopify_obj.try(:shipping_address).present? 
    	existing_order_numbers = Order.where("shopify_order_id = ? and deleted_at IS NULL",@order.shopify_order_id)
    	unless existing_order_numbers.nil?
      		existing_order_numbers.destroy_all   
    	end 
      
      puts "+++++++++++++++++++++++++++++++++++++++++++"
      puts @order.order_number
      puts "+++++++++++++++++++++++++++++++++++++++++++"
    	if @order.save
      		puts "========================== I am at shopify save if part"
      	else
      		puts @order.errors.full_messages
      	end
  	end

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |order|
            csv << order.attributes.values_at(*column_names)
        end
      end
    end

end
