ShopifyApp.configure do |config|
  config.api_key = ENV["shopify_api_key"]
  config.secret = ENV["shopify_secret"]
  config.scope = "read_script_tags, write_script_tags, write_orders, read_orders, read_products, read_customers, write_products, write_customers, write_shipping"
  config.embedded_app = true  
  # config.webhooks = [
  #   {topic: 'carts/create', address: "https://pepsiprintmedia.com/carts_update", format: "json"},
  #   {topic: 'carts/update', address: "https://pepsiprintmedia.com/carts_update", format: "json"},
  #   {topic: 'orders/create', address: "https://pepsiprintmedia.com/order_create", format: "json"},
  #   {topic: 'customers/update', address: "https://pepsiprintmedia.com/customer_update", format: "json"}
  # ]
  # config.scripttags = [
  #   {event:'onload', src: "https://pepsiprintmedia.com/update_cart.js", format: "script"}
  # ]
end
# SITE_URL = 'https://pepsiprintmedia.com'

Rails.application.configure do
  config.api_key = "15a617046caa88187fcc5f70f18284a8"
  config.api_secret = "ed0b5  f6d7bce201bcc5cc29020796e6e"
end
