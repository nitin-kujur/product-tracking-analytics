json.order do
  json.id order.id
  json.order_number = order.order_number
  json.shop_id order.shop_id
  json.customer_id order.customer_id
  json.shopify_order_id order.shopify_order_id
  json.email order.email
  json.closed_at order.email
  json.shopify_created_at order.email
  json.shopify_updated_at order.shopify_updated_at
  json.total_price order.total_price
  json.subtotal_price order.subtotal_price
  json.total_weight = order.total_weight
  json.total_tax = order.total_tax
  json.financial_status = order.financial_status
  json.total_line_items_price = order.total_line_items_price
  json.cancelled_at = order.cancelled_at
  json.cancel_reason = order.cancel_reason
  json.processed_at = order.processed_at
  json.fulfillment_status = order.fulfillment_status
  json.contact_email = order.contact_email
  json.billing_address_id = order.billing_address_id
  json.shipping_address_id = order.shipping_address_id
  json.shopify_customer_id = order.shopify_customer_id
  json.customer_email = order.customer_email
  json.order_region = order.order_region
  json.deleted_at = order.deleted_at
  json.discount_codes = order.discount_codes
  json.client_details = order.client_details
  json.parent_order_id = order.parent_order_id
  json.shopify_tracking_id = order.shopify_tracking_id
  json.amount = order.amount
  json.tracking_url = order.tracking_url
  json.shipped_date = order.shipped_date
  json.order_type = order.order_type
  json.url url_for(@message.creator, format: :json)
end