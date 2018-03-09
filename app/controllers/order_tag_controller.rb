class OrderTagController < ApplicationController
  def index
  	@order_tags = OrderTag.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @order_tags.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
