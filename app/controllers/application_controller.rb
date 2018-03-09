class ApplicationController < ActionController::Base
  include ShopifyApp::LoginProtection
  protect_from_forgery with: :exception

  protected
  def after_sign_up_path_for(resource)
	home_index_path
  end
  def after_sign_in_path_for(resource)
	home_index_path
  end
end
