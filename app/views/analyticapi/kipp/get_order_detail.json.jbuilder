json.id @order.id
json.name @order.order_number
json.email @order.customer.try(:email)
json.first_name @order.try(:customer).try(:first_name)
json.last_name @order.try(:customer).try(:last_name)
json.created_at @order.shopify_updated_at.strftime("%m/%d/%Y")
json.cancelled_at @order.cancelled_at.try(:strftime, "%m/%d/%Y")
json.cancelled_st atus @order.try(:cancelled_at).try(:to_bool).try(:to_s)
json.payment_status @order.financial_status.split('_').map(&:capitalize).join(' ')
if @order.fulfillment_status.nil? 
  json.fulfillment_status  "Unfulfilled" 
else
  json.fulfillment_status @order.fulfillment_status.titleize
end
json.total_price @order.total_price
json.line_items @order.line_items
json.products @order.products
json.billing_address @order.billing_address
json.shipping_address @order.shipping_address

