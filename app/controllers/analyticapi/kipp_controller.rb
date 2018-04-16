class Analyticapi::KippController < ApplicationController
  def index
  end

  def search_orders
    @orders = []
    if params[:page].present? && params[:per_page].present?
      @page = params[:page]
      @per_page = params[:per_page]
    else
      params[:page] = 1
      params[:per_page] = 10
      @page = params[:page]
      @per_page = params[:per_page]
    end

    if params[:domain].present? && params[:search_term].present? && params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      if @orders.empty?
        @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) || lower(CONCAT_WS(' ', first_name, last_name)) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      else
        @orders.merge(shop.orders.joins(:customer).where("lower(CONCAT_WS(' ', first_name, last_name)) || lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50))
      end
      @orders = @orders.where("lower(school) like ?", "%#{params[:school].strip.downcase}%")
    elsif params[:domain].present? && !params[:search_term].present? && params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(school) like ?", "%#{params[:school].strip.downcase}%")
    elsif params[:domain].present? && params[:search_term].present? && !params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      if @orders.empty?
        @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) || lower(CONCAT_WS(' ', first_name, last_name)) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      else
        @orders.merge(shop.orders.joins(:customer).where("lower(CONCAT_WS(' ', first_name, last_name)) || lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50))
      end
    elsif params[:domain].present? && !params[:search_term].present? && !params[:school].present?     
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders
    end

    if params[:start_date].present? && params[:end_date].present?
      @orders = @orders.where("DATE(shopify_created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date])
    end

    unless @orders.empty?
      if params[:order].present?
        @orders = @orders.order(order_number: "#{params[:order]}")
      elsif params[:order_by].present?
        @orders = @orders.joins(:customer).order("customers.first_name #{params[:order_by]}, customers.last_name #{params[:order_by]}")
      elsif params[:date].present?
        @orders = @orders.order(shopify_created_at: "#{params[:date]}")
      elsif params[:school_sort].present?
        @orders = @orders.order(school: "#{params[:school_sort]}")
      elsif params[:payment_status].present?
        @orders = @orders.order(financial_status: "#{params[:payment_status]}")
      elsif params[:order_status].present?
        @orders = @orders.order(fulfillment_status: "#{params[:order_status]}")
      elsif params[:tracking_id].present?
        @orders = @orders.order(shopify_tracking_id: "#{params[:tracking_id]}")
      elsif params[:quantity].present?
        @orders = @orders.joins(:line_items).order("line_items.quantity #{params[:quantity]}")
      elsif params[:total].present?
        @orders = @orders.order(total_price: "#{params[:total]}")
      end
    end

    if @orders.empty?
      respond_to do |format|  ## Add this
        puts "++++++++++++++++++++++++++="
        puts "I am into else"
        puts "++++++++++++++++++++++++++="
        format.json { render json: {'error' => 'No orders found..', :status => "400"} }
      end
    else
      @orders = @orders.paginate(:page => @page, :per_page => @per_page)
      @total_orders = @orders.count  
      respond_to do |format|
        format.json
      end
    end
  end

  def search_date_range_orders
    @orders = []
    if params[:page].present? && params[:per_page].present?
      @page = params[:page]
      @per_page = params[:per_page]
    else
      params[:page] = 1
      params[:per_page] = 10
      @page = params[:page]
      @per_page = params[:per_page]
    end

    if params[:domain].present? && params[:search_term].present? && params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      if @orders.empty?
        @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) || lower(CONCAT_WS(' ', first_name, last_name)) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      else
        @orders.merge(shop.orders.joins(:customer).where("lower(CONCAT_WS(' ', first_name, last_name)) || lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50))
      end
      @orders = @orders.where("lower(school) like ?", "%#{params[:school].strip.downcase}%")
    elsif params[:domain].present? && !params[:search_term].present? && params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(school) like ?", "%#{params[:school].strip.downcase}%")
    elsif params[:domain].present? && params[:search_term].present? && !params[:school].present?
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders.where("lower(order_number) like ?", "%#{params[:search_term].strip.downcase}%" ).where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      if @orders.empty?
        @orders = shop.orders.joins(:customer).where("lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) || lower(CONCAT_WS(' ', first_name, last_name)) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      else
        @orders.merge(shop.orders.joins(:customer).where("lower(CONCAT_WS(' ', first_name, last_name)) || lower(customers.first_name) || lower(customers.last_name) || lower(customers.email) like ?", "%#{params[:search_term].strip.downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50))
      end
    elsif params[:domain].present? && !params[:search_term].present? && !params[:school].present?     
      shop = Shop.where(:shopify_domain => params[:domain]).first
      @orders = shop.orders
    end

    if params[:start_date].present? && params[:end_date].present?
      @orders = @orders.where("DATE(shopify_created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date])
    end

    unless @orders.empty?
      if params[:order].present?
        @orders = @orders.order(order_number: "#{params[:order]}")
      elsif params[:order_by].present?
        @orders = @orders.joins(:customer).order("customers.first_name #{params[:order_by]}, customers.last_name #{params[:order_by]}")
      elsif params[:date].present?
        @orders = @orders.order(shopify_created_at: "#{params[:date]}")
      elsif params[:school_sort].present?
        @orders = @orders.order(school: "#{params[:school_sort]}")
      elsif params[:payment_status].present?
        @orders = @orders.order(financial_status: "#{params[:payment_status]}")
      elsif params[:order_status].present?
        @orders = @orders.order(fulfillment_status: "#{params[:order_status]}")
      elsif params[:tracking_id].present?
        @orders = @orders.order(shopify_tracking_id: "#{params[:tracking_id]}")
      elsif params[:quantity].present?
        @orders = @orders.joins(:line_items).order("line_items.quantity #{params[:quantity]}")
      elsif params[:total].present?
        @orders = @orders.order(total_price: "#{params[:total]}")
      end
    end

    if @orders.empty?
      respond_to do |format|  ## Add this
        puts "++++++++++++++++++++++++++="
        puts "I am into else"
        puts "++++++++++++++++++++++++++="
        format.json { render json: {'error' => 'No orders found..', :status => "400"} }
      end
    else
      @orders = @orders.paginate(:page => @page, :per_page => @per_page)
      @total_orders = @orders.count  
      respond_to do |format|
        format.json
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
              local_order.order_tags.build(name: "PaidAt", value: params[:school])
              local_order.order_tags.build(name: "PaidThrough", value: params[:cid])
              local_order.amount = @order.transactions.last.amount
              local_order.financial_status = "paid"
              puts "====================================="
              puts @order.transactions.last.amount
              puts "====================================="
              local_order.save(:validate => false)
              puts "---------------------------------"
              puts local_order.errors.inspect
              puts "---------------------------------"
              puts "Local Order saved"
      				UserMailer.order_paid_email(@order, params)
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
    if params[:shopify_order_id].present?
      puts "-------- I am into gt order detail------------"
      puts params[:shopify_order_id]
      puts "-------- I am into gt order detail------------"
      @order = Order.where(:shopify_order_id => params[:shopify_order_id]).first
      @ocr = URI.decode(@order.tags.try(:split, ',').collect(&:strip).select{|x| /Ocr\d*:/ =~ x}.sort.join.gsub(/Ocr\d*:/,""))
      @ocr = @ocr.present? ? @ocr : nil
      
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

  def save_shopify_order
    shop = Shop.where(:shopify_domain => params[:domain]).first
    Shop.set_session(shop)
    @order = ShopifyAPI::Order.find(params[:shopify_order_id])
    Order.save_shopify_order(shop, @order)
    format.json { render json: {'message' => "ok", :status => "200"} } 
  end

  def product_track
    puts "---------Number of params present--------"
    puts params
    puts "---------Number of params present--------"
    @product_track_arr = []
    if params[:domain].present? 
      @shop = Shop.find_by_shopify_domain(params[:domain])
      @shop.orders.each do |order|
        order.products.each do |product|
          product.variants.each do |variant|
            product_track_arr = {:sku = variant.sku, :product_name = product.title, :unit_sold = order.quantity, :amount = order.total_price, :boh = variant.inventory_quantity, :eoh = variant.inventory_quantity - order.quantity}
          end
      end
    end
  end
end
