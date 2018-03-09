class OrderController < ApplicationController
  def index
  	@orders = Order.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @orders.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
