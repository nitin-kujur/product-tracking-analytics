json.orders @orders do |order|
  json.id order.id
  json.name order.order_number
  json.email order.email
  json.first_name order.customer.first_name
  json.last_name order.customer.last_name
  json.created_at order.shopify_updated_at.strftime("%m/%d/%Y")
  json.payment_status order.financial_status
  json.fulfillment_status if order.fulfillment_status.nil? ? "Unfulfilled" : order.fulfillment_status.try(:titleize)
  json.total_price order.total_price
end
json.total_orders @total_orders
json.per_page @per_page
json.page @page