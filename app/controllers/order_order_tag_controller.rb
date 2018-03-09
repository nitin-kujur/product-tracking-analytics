class OrderOrderTagController < ApplicationController
  def index
  	@Orders = OrderOrderTag.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @Orders.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
