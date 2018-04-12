class LandingController < ApplicationController
  # skip_before_action :authenticate_user!, only: :update_order_webhook
  protect_from_forgery except: :update_order_webhook
  require 'will_paginate/array'
  def index
    puts "***********************************"
    puts params
    puts "***********************************"
    if params[:reset].present?
      puts "======= 1. Reset parameters ============="
      @form_date = nil
      @to_date = nil
      @shop = nil
    end
    @form_date = params[:form_date]
    @to_date = params[:to_date]
    @shop = params[:shop_id]
    if params[:form_date].present? && params[:to_date].present? || params[:shop_id].present?
      puts "---------2. All Paramter present-----------"
      if !params[:form_date].empty? && !params[:to_date].empty? && !params[:shop_id].empty?
        puts "++++++++ 3. All parameter not empty ++++++++++"
        if params[:shop_id] == "all"
          puts "=========== 4. shop parameter set to all ======="
          @orders = Order.where(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
          @cancelled_orders = Order.where.not(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
        else
          puts "=========== 5. shop parameter not set to all ======="
          @orders = Order.where(:shop_id => params[:shop_id]).where(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
          @cancelled_orders = Order.where(:shop_id => params[:shop_id]).where.not(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
        end
      elsif params[:form_date].empty? && params[:to_date].empty? && !params[:shop_id].empty?
        puts "++++++++6. Shop parameter not empty ++++++++++"
        if params[:shop_id] == "all"
          @orders = Order.where(:cancelled_at => nil)
          @cancelled_orders = Order.where.not(:cancelled_at => nil)
        else
          @orders = Order.where(:shop_id => params[:shop_id]).where(:cancelled_at => nil)
          @cancelled_orders = Order.where(:shop_id => params[:shop_id]).where.not(:cancelled_at => nil)
        end  
      elsif !params[:form_date].empty? && !params[:to_date].empty? && params[:shop_id].empty?
        puts "++++++++6. Shop parameter not empty ++++++++++"
        @orders = Order.where(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
        @cancelled_orders = Order.where.not(:cancelled_at => nil).where("date(shopify_created_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
      end
      @flag = "search_result"
    else
      puts "---------Paramter not present-----------"
      if params["unfulfilled"].present? || params["fulfilled"].present? || params["cancelled"].present? || params[:billed_to_search].present? || params[:shipped_to_search].present? || params[:item_search].present? || params[:tracking_number].present? || params[:free_text_search].present? || params[:sku_search].present? || params[:order_name_search].present? || params["archived"].present?
        @orders = Order.where(:cancelled_at => nil)
        @cancelled_orders = Order.where.not(:cancelled_at => nil)
      end  
    end

    if params["fulfilled"].present?
      @orders = @orders.where(:fulfillment_status => "fulfilled").where(:cancelled_at => nil)
      @flag = "search_result"
    elsif params["unfulfilled"].present?
      @orders = @orders.where(:fulfillment_status => nil).where(:cancelled_at => nil)
      @flag = "search_result"
    elsif params["cancelled"].present?
      @orders =  @cancelled_orders #Order.where.not(:cancelled_at => nil).where(:shop_id => params[:shop_id]).paginate(:page => params[:page], :per_page => 50)
      @flag = "search_result"
    elsif params["archived"].present?
      @orders =  @orders.where.not(:closed_at => nil)
      @flag = "search_result"
    end

    if params[:billed_to_search].present?
      if @orders_search.nil?
        puts "I am into if block"
        @orders_search = @orders.joins(:billing_address).where("lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.city) like ?", "%#{params[:billed_to_search].strip.downcase}%").where(:cancelled_at => nil)
      else
        puts "I am into else block"
        @order_name = @orders.joins(:billing_address).where("lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.city) like ?", "%#{params[:billed_to_search].strip.downcase}%").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end
      puts "-----------------------------------"
      puts @orders_search.count
      puts "-----------------------------------"
      @flag = "no_search_result"
    end

    if params[:shipped_to_search].present?
      puts "================shipped_to_search===================="
      if @orders_search.nil?
        puts "I am into if block"
        @orders_search = @orders.joins(:shipping_address).where("lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.city) like ?", "%#{params[:shipped_to_search].strip.downcase}%").where(:cancelled_at => nil)
      else
        puts "I am into else block"
        @order_name = @orders.joins(:shipping_address).where("lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.city) like ?", "%#{params[:shipped_to_search].strip.downcase}%").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end 
      puts "-----------------------------------"
      puts @orders_search.count
      puts "-----------------------------------"
      @flag = "no_search_result"
    end

  	if params[:item_search].present?
      puts "================item_search===================="
      if @orders_search.nil?
        @orders_search = @orders.joins(:line_items).where("lower(line_items.title) like ?", "#{params[:item_search].strip.downcase}").where(:cancelled_at => nil)
      else
        @order_name = @orders.joins(:line_items).where("lower(line_items.title) like ?", "#{params[:item_search].strip.downcase}").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end  
      @flag = "no_search_result"
    end

  	if params[:tracking_number].present?
      puts "================tracking_number===================="
      if @orders_search.nil?
        @orders_search = @orders.where("lower(shopify_tracking_id) like ?", "%#{params[:tracking_number].strip.downcase}%").where(:cancelled_at => nil)
      else
        @order_name = @orders.where("lower(shopify_tracking_id) like ?", "%#{params[:tracking_number].strip.downcase}%").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end 
      @flag = "no_search_result"
    end

  	if params[:free_text_search].present?
      puts "================free_text_search===================="
      if @orders_search.nil?
        @orders_search = @orders.where("lower(email) || total_price || subtotal_price || total_weight || total_tax || lower(financial_status) || total_line_items_price || cancelled_at || lower(cancel_reason) || lower(order_number) || lower(fulfillment_status) || lower(contact_email) || lower(customer_email) || lower(order_region) || lower(discount_codes) || lower(shopify_tracking_id) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil)
        @order_name2 = @orders.joins(:billing_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil).where(:cancelled_at => nil)
        @order_name3 = @orders.joins(:shipping_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil).where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name2 + @order_name3
      else
        @order_name1 = @orders.where("lower(email) || total_price || subtotal_price || total_weight || total_tax || lower(financial_status) || total_line_items_price || cancelled_at || lower(cancel_reason) || lower(order_number) || lower(fulfillment_status) || lower(contact_email) || lower(customer_email) || lower(order_region) || lower(discount_codes) || lower(shopify_tracking_id) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil)
        @order_name2 = @orders.joins(:billing_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil).where(:cancelled_at => nil)
        @order_name3 = @orders.joins(:shipping_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].strip.downcase}%").where(:cancelled_at => nil).where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name1 + @order_name2 + @order_name3
      end 
      @flag = "no_search_result"
    end

    if params[:sku_search].present?
      puts "================sku_search===================="
      if @orders_search.nil?
        @orders_search = @orders.joins(:line_items).where("lower(line_items.sku) like ?", "%#{params[:sku_search].strip.downcase}%").where(:cancelled_at => nil)
      else
        @order_name = @orders.joins(:line_items).where("lower(line_items.sku) like ?", "%#{params[:sku_search].strip.downcase}%").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end
      @flag = "no_search_result"
    end

    if params[:order_name_search].present?
      puts "================order_name_search===================="
      # puts @orders_search.map(&:order_number)
      puts "================order_name_search===================="
      if @orders_search.nil?
        puts "I am into if block"
        @orders_search = @orders.where("lower(order_number) like ?", "%#{params[:order_name_search].strip.downcase}%").where(:cancelled_at => nil)
      else
        puts "I am into else block"
        @order_name = @orders.where("lower(order_number) like ?", "%#{params[:order_name_search].strip.downcase}%").where(:cancelled_at => nil)
        @orders_search = @orders_search + @order_name
      end   
      puts "-----------------------------------"
      puts @orders_search.count
      puts "-----------------------------------"
      puts "------------------------------"
      @flag = "no_search_result"
      puts @flag
      puts "------------------------------"
    end

    unless @orders_search.nil?
      @orders = @orders_search.paginate(:page => params[:page], :per_page => 50)
    end
    if params[:form_date].present? && params[:to_date].present? || params[:shop_id].present? || params["fulfilled"].present? || params["unfulfilled"].present? || params["cancelled"].present? || params["archived"].present? || params[:order_name_search].present? || params[:sku_search].present? || params[:free_text_search].present? || params[:tracking_number].present? || params[:item_search].present? || params[:shipped_to_search].present? || params[:billed_to_search].present?
      @orders_count = @orders.where(:order_type => "Child").count
      @orders_quantity = @orders.where(:order_type => "Child").joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders.where(:order_type => "Child").sum(:total_price)
      @orders_to_csv = @orders
      @orders = @orders.paginate(:page => params[:page], :per_page => 50)
      respond_to do |format|
        format.html
        format.csv { send_data Order.to_csv(@orders_to_csv) }
      end
    else
      @orders_for_count = Order.where(:order_type => "Child").where(:cancelled_at => nil).where(:order_type => "Child")
      @orders_count = @orders_for_count.count
      @orders_quantity = @orders_for_count.joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders_for_count.sum(:total_price)
      respond_to do |format|
        format.html
        format.csv { render text: Order.to_csv(@orders_for_count) }
      end
      @flag = "no_search_result"
    end
  end

  def update_order_webhook
    puts "-------------------------------------"
    puts params
    puts db_shopify_updated_at.strftime("%m/%d/%Y/%s") 
    puts params[:updated_at].strftime("%m/%d/%Y/%s")
    puts "-------------------------------------"
    db_shopify_updated_at = Order.find_by_shopify_id(params[:id]).shopify_updated_at
    unless db_shopify_updated_at.strftime("%m/%d/%Y/%s") == params[:updated_at].strftime("%m/%d/%Y/%s")
      shop = request.headers["HTTP_X_SHOPIFY_SHOP_DOMAIN"]
      shopify_obj = params
      Order.save_shopify_order(shop, shopify_obj)
    end
    format.json { render json: {'message' => "ok", :status => "200"} } 
   
  end
end
