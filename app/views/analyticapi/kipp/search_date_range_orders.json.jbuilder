json.orders @orders do |order|
  json.id order.shopify_order_id
  json.name order.order_number
  json.school order.school
  json.cancelled_at order.cancelled_at
  json.email order.customer.try(:email)
  json.first_name order.try(:customer).try(:first_name)
  json.last_name order.try(:customer).try(:last_name)
  json.created_at order.shopify_created_at.strftime("%m/%d/%Y")
  json.shopify_tracking_id order.shopify_tracking_id || (order.tags.includes?("fulfilled_at_school")) ? "Fulfilled at School" : ''
  json.quantity order.line_items.sum(:quantity)
  json.payment_status order.financial_status.split('_').map(&:capitalize).join(' ')
  if order.fulfillment_status.nil? 
    json.fulfillment_status  "Unfulfilled" 
  else
    json.fulfillment_status order.fulfillment_status.titleize
  end
  json.total_price number_with_precision(order.total_price, :precision => 2)
end
json.total_orders @total_orders
json.per_page @per_page
json.page @page