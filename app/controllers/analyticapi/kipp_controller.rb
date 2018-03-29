class Analyticapi::KippController < ApplicationController
  def index
  end

  def search_orders
	 puts "=============================="
	 puts params  	
	 puts "=============================="
	if params[:domain].present? && params[:search_term].present?
	 		shop = Shop.where(:shopify_domain => params[:domain]).first
	 		@orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil)
	 		if @orders.empty?
	 			@orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil)
	 		end	
	 		respond_to do |format|  ## Add this
    			format.json { render json: @orders, status: :ok}
    		end
	elsif params[:domain].present?
  		shop = Shop.where(:shopify_domain => params[:domain]).first
	 	@orders = shop.orders
	 	respond_to do |format|  ## Add this
    		format.json { render json: @orders, status: :ok}
    	end
  	else
  		respond_to do |format|  ## Add this
    		format.json { render json: {'error' => 'No orders found..', :status => "400"} }
    	end
  	end
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
