json.orders @orders do |order|
  json.id order.id
  json.name order.order_number
  json.email order.customer.try(:email)
  json.first_name order.try(:customer).try(:first_name)
  json.last_name order.try(:customer).try(:last_name)
  json.created_at order.shopify_updated_at.strftime("%m/%d/%Y")
  json.payment_status order.financial_status.split('_').map(&:capitalize).join(' ')
  if order.fulfillment_status.nil? 
    json.fulfillment_status  "Unfulfilled" 
  else
    json.fulfillment_status order.fulfillment_status
  end
  json.total_price order.total_price
end
json.total_orders @total_orders
json.per_page @per_page
json.page @page