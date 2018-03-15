class LandingController < ApplicationController
  def index
  	if params[:billed_to_search].present?
      @orders = Order.joins(:billing_address).where(addresses: {city: "#{params[:billed_to_search]}"}).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:shipped_to_search].present?
      @orders = Order.joins(:shipping_address).where(addresses: {city: "#{params[:shipped_to_search]}"}).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:item_search].present?
  		@orders = Order.all.limit(200).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:tracking_number].present?
      @orders = Order.where(:shopify_tracking_id => params[:tracking_number]).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:free_text_search].present?
      @orders = Order.where("email || total_price || subtotal_price || total_weight || total_tax || financial_status || total_line_items_price || cancelled_at || cancel_reason || order_number || fulfillment_status || contact_email || customer_email || order_region || discount_codes || shopify_tracking_id like ?", "%#{params[:free_text_search]}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      @orders << Order.joins(:billing_address).where("addresses.city || addresses.first_name || addresses.last_name || addresses.address1 || addresses.zip || addresses.name like ?", "%#{params[:free_text_search]}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      @orders << Order.joins(:shipping_address).where("addresses.city || addresses.first_name || addresses.last_name || addresses.address1 || addresses.zip || addresses.name like ?", "%#{params[:free_text_search]}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    elsif params[:sku_search].present?
      @orders = Order.where("sku like ?", "%#{params[:sku_search]}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    elsif params[:order_name_search].present?
      @orders = Order.where("order_number like ?", "%#{params[:order_name_search]}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    else 
      @orders = Order.paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
  	end
    @orders_count = Order.all.where(:cancelled_at => nil).count
  	@orders_quantity = LineItem.sum(:quantity)
  	@shops = Shop.all
  	@sales = LineItem.sum(:price) * LineItem.sum(:quantity)
  end
end
