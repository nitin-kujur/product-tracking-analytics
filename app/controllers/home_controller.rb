class HomeController < ApplicationController
  def index
  	if params[:billed_to_search].present?
      @flag = 0 
  		@address = Address.where(:city => params[:billed_to_search]).joins(:billing_orders)
      puts "--------------------"
      puts @address.inspect
      puts "--------------------"
  	elsif params[:shipped_to_search].present?
      @flag = 2
  		@address = Address.joins(:shipping_orders).where(:city => params[:shipped_to_search])
  	elsif params[:item_search]
  		@orders = Order.all
  	elsif params[:tracking_number]
      @flag = 1
  		@orders = Order.all
  	else
      @flag = 1
  		@orders = Order.all
  	end
    @orders_count = Order.all.count
  	@orders_quantity = LineItem.sum(:quantity)
  	@shops = Shop.all
  	@sales = LineItem.sum(:price) * LineItem.sum(:quantity)
  end
end
