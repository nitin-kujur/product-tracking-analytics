class LineItemController < ApplicationController
  def index
  	@line_items = LineItem.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @line_items.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
