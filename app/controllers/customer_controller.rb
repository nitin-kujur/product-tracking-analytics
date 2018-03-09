class CustomerController < ApplicationController
  def index
  	@customers = Customer.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @customers.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
