json.order do
  json.id order.id
  json.order_number = order.order_number
  json.email order.email
  json.first_name order.customer.first_name
  json.last_name order.customer.last_name
  json.shopify_updated_at order.shopify_updated_at
  json.payment_status = order.financial_status
  json.fulfillment_status = order.fulfillment_status
  json.total_price order.total_price
end