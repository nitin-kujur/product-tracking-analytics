class Analyticapi::KippController < ApplicationController
  def index
  end


  # Response : {"order":[{"id":"375065706558","name":"LTS1096","email":"nkujur@lapineinc.com","first_name":"Nitin","last_name":"Kujur","date_unix":"03/15/2018","created_at":"March 15, 2018","payment_status":"Pending","fulfillment_status":"Unfulfilled","total_price":"$85.08"}]}
  # Type : get
  # Params : params["search_term"], params["school"], params["domain"], params["page"]
  def search_orders
	 puts "=============================="
	 puts params  	
	 puts "=============================="
    if params[:page].present? && params[:per_page].present?
        @page = params[:page]
        @per_page = params[:per_page]
    else
        params[:page] = 1
        params[:per_page] = 10
        @page = params[:page]
        @per_page = params[:per_page]
    end
	if params[:domain].present? && params[:search_term].present?
	 	shop = Shop.where(:shopify_domain => params[:domain]).first
	 	@orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      if @orders.empty?
	 		  @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) || lower(CONCAT_WS(' ', first_name, last_name)) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
	 	  end	
        @total_orders = @orders.count
	 	respond_to do |format|
            format.json
        end
	elsif params[:domain].present?
  		shop = Shop.where(:shopify_domain => params[:domain]).first
	 	@orders = shop.orders.paginate(:page => params[:page], :per_page => 50)
        @total_orders = @orders.count
	 	respond_to do |format|
            format.json
        end  
  	else
        respond_to do |format|  ## Add this
            puts "++++++++++++++++++++++++++="
            puts "I am into else"
            puts "++++++++++++++++++++++++++="
    		format.json { render json: {'error' => 'No orders found..', :status => "400"} }
    	end
  	end
  end

  def get_order_detail

  end

  # def kipp_order_mark_paid
 	# if params[:id].present? && params[:school].present? && params[:cid].present? && params[:domain].present?
  # 		@order = ShopifyAPI::Order.find(params[:id])
  # 		if @order.present?
  #  			if @order.fulfillment_status == 'paid'
  #   			respond_to do |format|
  #           		format.json { render json: {'error' => 'Payment already done for this order.', :status => "400"} }
  #         		end
  #  			else
  #   			transaction = ShopifyAPI::Transaction.new
  #   			transaction.kind = "capture"
  #   			transaction.amount = @order.transactions.last.amount
  #   			transaction.prefix_options={:order_id => @order.id}
  #   			if transaction.save
  #    				order_tags = @order.tags.split(',')
  #    				order_tags << "PaidAt:#{params[:school_id]}"
  #    				order_tags << "PaidThrough:#{params[:cid]}"
  #    				@order.tags = order_tags.join(",")
  #    				if @order.save
  #     					Order.update(@order)
  #     					UserMailer.order_paid_email(@order, params).deliver_now
  #     					respond_to do |format|
  #             				format.json { render json: {'message' => 'Order successfully marked as paid.', :status => "200"} }
  #           			end
  #    				end
  #   			end
  #  			end
  # 		end
 	# else
  # 		respond_to do |format|
  #         format.json { render json: {'error' => 'Insufficient params provided.', :status => "400"} }
  #       end
 	# end
  # end
end
