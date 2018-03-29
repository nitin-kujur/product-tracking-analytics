Rails.application.routes.draw do
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

  namespace :analyticapi do
    get  "/product-tracking-analytics/login"  => "home#index",  :as => 'login'
    get  "/product-tracking-analytics/index"  => "landing#index"
  end

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
