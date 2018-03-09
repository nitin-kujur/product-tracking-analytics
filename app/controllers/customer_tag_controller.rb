class CustomerTagController < ApplicationController
  def index
  	@customer_tags = CustomerTag.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @customer_tags.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
