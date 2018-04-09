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
	 		  @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
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

  def kipp_order_mark_paid
 	  if params[:id].present? && params[:school].present? && params[:cid].present? && params[:domain].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      Shop.set_session(shop)
  		@order = ShopifyAPI::Order.find(params[:id])
      puts "---------------------------------"
      puts @order.inspect
      puts "---------------------------------"
  		if @order.present?
   			if @order.fulfillment_status == 'paid'
          puts "I am into order fullfilment status paid"
    			respond_to do |format|
            format.json { render json: {'error' => 'Payment already done for this order.', :status => "400"} }
          end
   			else
          puts "I am into else part of order fullfilment"
    			transaction = ShopifyAPI::Transaction.new
    			transaction.kind = "capture"
    			transaction.amount = @order.transactions.last.amount
    			transaction.prefix_options={:order_id => @order.id}
          transaction.save
    			# if transaction.save
            puts "Transaction saved"
     				order_tags = @order.tags.split(',')
     				order_tags << "PaidAt:#{params[:school_id]}"
     				order_tags << "PaidThrough:#{params[:cid]}"
     				@order.tags = order_tags.join(",")
     				if @order.save
              puts "Order saved"
      				local_order = Order.where(:shopify_order_id => params[:id]).first
              local_order.order_tags.build(name: "PaidAt", value: params[:school_id])
              local_order.order_tags.build(name: "PaidThrough", value: params[:cid])
              local_order.amount = @order.transactions.last.amount
              local_order.fulfillment_status = @order.fulfillment_status
              local_order.save
              puts "Local Order saved"
      				UserMailer.order_paid_email(@order, params).deliver_now
              puts "user email triggered"
      				respond_to do |format|
              	format.json { render json: {'message' => 'Order successfully marked as paid.', :status => "200"} }
            	end
     				end
    			# end
   			end
  		end
 	  else
      puts "I am into main else"
  		respond_to do |format|
        format.json { render json: {'error' => 'Insufficient params provided.', :status => "400"} }
      end
 	  end
  end

  def get_order_detail
    if params[:name].present?
      @order = Order.find_by_order_number(params[:name])
      if @order.nil?
        respond_to do |format|
          format.json { render json: {'error' => 'No orders found..', :status => "400"} }
        end
      else
        respond_to do |format|
          format.json
        end
      end
    end
  end

  def cancel_order
    if params[:order_id].present? && params[:domain].present?
     shop = Shop.where(:shopify_domain => params[:domain]).first
     Shop.set_session(shop)
     @order = ShopifyAPI::Order.find(params[:order_id])
     @order_local = Order.find_by_shopify_order_id(@order.id)
     @order.cancel({"order":{"amount": @order.total_price, "reason":params[:reason]}})
     order_tags = @order.tags.split(',')
     require 'uri'
     ocr_a = URI.encode(params[:reason]).scan(/.{1,35}/)
     ocr_a.each_with_index do |x, i| 
        puts "000000000000000000000000000000000000000"
        puts x
        puts i
        puts "000000000000000000000000000000000000000"
        @order.tags << "Ocr#{i}:#{x}"
       @order_local.order_tags.build(:name =>"Ocr#{i}", value: "#{x}")
     end 
     # order_tags << "Ocr:#{params[:reason]}"
     # @order.tags = order_tags.join(",")
     if @order.save
       @order_local.cancelled_at = @order.cancelled_at
       @order_local.save
       puts "-------------------------"
       puts @order_local.inspect
       puts "-------------------------"

       respond_to do |format|
         puts "====================================="
         puts params[:reason]
         puts @order_local.inspect
         puts "====================================="
         UserMailer.order_cancellation_email(@order_local, params[:reason]).deliver_now
         format.json { render json: {'message' => "ok", :status => "200"} }
       end
        else
         respond_to do |format|
           format.json { render json: {'message' => "#{@order.errors.full_messages}", :status => "400"} }
         end
     end
    else
     respond_to do |format|
          format.json { render json: {'error' => 'Insufficient params provided.', :status => "400"} }
        end
    end
  end
end
