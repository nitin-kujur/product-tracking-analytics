Rails.application.routes.draw do
  namespace :analyticapi do
    root to: 'kipp#index'
    get 'premium/index'
    get '/search', to: 'kipp#search_orders', format: 'json'
    get '/orders', to: 'kipp#search_date_range_orders', format: 'json'
    get '/update', to: 'kipp#kipp_order_mark_paid', format: 'json'
    get '/get_order_detail', to: 'kipp#get_order_detail', format: 'json'
    get '/cancel_order', to: 'kipp#cancel_order', format: 'json'
    get '/save_order', to: 'kipp#save_shopify_order', format: 'json'
    # post '/update_order_webhook', to: 'kipp#update_order_webhook', format: 'json'
  end

  get 'home/index', as: :login
  get 'landing/index'

  mount ShopifyApp::Engine, at: '/'

  # namespace :app_proxy do
  #   root action: 'index'
  #   # simple routes without a specified controller will go to AppProxyController
    
  #   # more complex routes will go to controllers in the AppProxy namespace
  #   # 	resources :reviews
  #   # GET /app_proxy/reviews will now be routed to
  #   # AppProxy::ReviewsController#index, for example
  # end

  post 'update_order_webhook' => "landing#update_order_webhook"
  post '/update_order_webhook' => "landing#update_order_webhook"
  get 'order_order_tag/index'

  get 'product_product_tag/index'

  get 'customer_customer_tag/index'

  get 'variant/index'

  get 'line_item/index'

  get 'customer_tag/index'

  get 'product_tag/index'

  get 'order_tag/index'

  get 'order/index'

  get 'product/index'

  get 'customer/index'
  devise_for :users
  devise_scope :user do
  	root to: "devise/sessions#new"
  end
end
