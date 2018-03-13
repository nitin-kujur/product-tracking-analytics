ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "15a617046caa88187fcc5f70f18284a8"
  config.secret = "ed0b5f6d7bce201bcc5cc29020796e6e"
  config.scope = "read_orders, read_products, read_customers"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = ShopifyApp::InMemorySessionStore
end
