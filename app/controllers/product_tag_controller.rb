class ProductTagController < ApplicationController
  def index
  	@product_tags = ProductTag.all
  	respond_to do |format|
    	format.html
    	format.csv { send_data @product_tags.to_csv }
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
  end
end
