Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'
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

  get 'home/index'

  get 'customer/index'

  devise_for :users
  devise_scope :user do
  	root to: "devise/sessions#new"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
