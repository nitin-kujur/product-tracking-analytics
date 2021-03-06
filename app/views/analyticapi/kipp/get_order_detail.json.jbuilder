json.order do
	json.id @order.shopify_order_id
	json.name @order.order_number
	json.email @order.customer.try(:email)
	json.first_name @order.try(:customer).try(:first_name)
	json.last_name @order.try(:customer).try(:last_name)
	json.created_at @order.shopify_created_at.strftime("%m/%d/%Y")
	json.cancelled_at @order.cancelled_at.try(:strftime, "%m/%d/%Y")
	json.discount_codes @order.discount_codes
	json.shipping_charge number_with_precision(((@order.total_price - @order.subtotal_price ) - @order.total_tax), :precision => 2)
	json.shipping_ines @order.shipping_lines
	json.payment_status @order.financial_status.split('_').map(&:capitalize).join(' ')
	json.cancel_reason @order.cancelled_at ? @ocr || @order.tags.try(:split, ',').collect(&:strip).select{|x| /Ocr:/ =~ x}.first.try(:split, ":").try(:last) || "Other" : ""
	json.total_tax @order.total_tax
	if @order.fulfillment_status.nil? 
  		json.fulfillment_status  "Unfulfilled"
	else
  	json.fulfillment_status @order.fulfillment_status.titleize
	end
	json.total_price number_with_precision(@order.total_price, :precision => 2)
	json.subtotal_price number_with_precision(@order.subtotal_price, :precision => 2)
	json.line_items @order.line_items
	json.products @order.products
	json.billing_address @order.billing_address
	json.shipping_address @order.shipping_address
end
