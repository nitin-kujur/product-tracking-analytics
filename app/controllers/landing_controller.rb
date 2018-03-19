class LandingController < ApplicationController
  def index
    puts "+++++++++++++++++++++++++++++++++++++++++"
    puts params
    puts "+++++++++++++++++++++++++++++++++++++++++"
    if params[:reset].present?
      @form_date = nil
      @to_date = nil
      @shop = nil
    end
    @form_date = params[:form_date]
    @to_date = params[:to_date]
    @shop = params[:shop_id]
    if params[:form_date].present? && params[:to_date].present? || params[:shop_id].present?
      puts "---------Paramter present-----------"
      if !params[:form_date].empty? && !params[:to_date].empty? && !params[:shop_id].empty?
        puts "++++++++ All parameter not empty ++++++++++"
        @orders = Order.where(:shop_id => params[:shop_id]).paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
        @orders = @orders.where("date(processed_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
        @orders_count = @orders.count
        @orders_quantity = @orders.joins(:line_items).sum(:quantity)
        @shops = Shop.all
        @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
      elsif params[:form_date].empty? && params[:to_date].empty? && !params[:shop_id].empty?
        puts "++++++++ Shop parameter not empty ++++++++++"
        @orders = Order.where(:shop_id => params[:shop_id]).paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
        @orders_count = @orders.count
        @orders_quantity = @orders.joins(:line_items).sum(:quantity)
        @shops = Shop.all
        @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
      else
        puts "++++++++ from to not empty ++++++++++"
        @orders = Order.where("date(processed_at) BETWEEN ? AND ? ", "#{params[:form_date]}","#{params[:to_date]}")
        @orders_count = @orders.count
        @orders_quantity = @orders.joins(:line_items).sum(:quantity)
        @shops = Shop.all
        @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
      end
    else
      puts "---------Paramter not present-----------"
      # @orders = Order.all.paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
    end
    if params["fulfilled"].present?
      @orders = @orders.where(:fulfillment_status => "fulfilled").paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
      @orders_count = @orders.count
      @orders_quantity = @orders.joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
    elsif params["unfulfilled"].present?
      @orders = @orders.where(:fulfillment_status => nil).paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
      @orders_count = @orders.count
      @orders_quantity = @orders.joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
    elsif params["cancelled"].present?
      @orders = @orders.where.not(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      @orders_count = @orders.count
      @orders_quantity = @orders.joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
    elsif params[:billed_to_search].present?
      @orders = @orders.joins(:billing_address).where("lower(addresses.city) like ?", "%#{params[:billed_to_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    elsif params[:shipped_to_search].present?
      @orders = @orders.joins(:shipping_address).where("lower(addresses.city) like ?", "%#{params[:shipped_to_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:item_search].present?
      @orders = @orders.joins(:line_items).where("lower(line_items.title) like ?", "#{params[:item_search].downcase}").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:tracking_number].present?
      @orders = @orders.where("lower(shopify_tracking_id) like ?", "%#{params[:tracking_number].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
  	elsif params[:free_text_search].present?
      @orders = @orders.where("lower(email) || total_price || subtotal_price || total_weight || total_tax || lower(financial_status) || total_line_items_price || cancelled_at || lower(cancel_reason) || lower(order_number) || lower(fulfillment_status) || lower(contact_email) || lower(customer_email) || lower(order_region) || lower(discount_codes) || lower(shopify_tracking_id) like ?", "%#{params[:free_text_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
      @orders = @orders.joins(:billing_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50) if @orders.empty?
      @orders << @orders.joins(:shipping_address).where("lower(addresses.city) || lower(addresses.first_name) || lower(addresses.last_name) || lower(addresses.address1) || lower(addresses.zip) || lower(addresses.name) like ?", "%#{params[:free_text_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)  if @orders.empty?
    elsif params[:sku_search].present?
      @orders = @orders.joins(:line_items).where("lower(line_items.sku) like ?", "%#{params[:sku_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    elsif params[:order_name_search].present?
      @orders = @orders.where("lower(order_number) like ?", "%#{params[:order_name_search].downcase}%").where(:cancelled_at => nil).paginate(:page => params[:page], :per_page => 50)
    else 
        # @orders = @orders.paginate(:page => params[:page], :per_page => 50).where(:cancelled_at => nil)
        # @orders_count = @orders.all.where(:cancelled_at => nil).count
        # @orders_quantity = @orders.joins(:line_items).sum(:quantity)
        # @shops = Shop.all
        # @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
  	end
      @orders_count = @orders.count
      @orders_quantity = @orders.joins(:line_items).sum(:quantity)
      @shops = Shop.all
      @sales = @orders.joins(:line_items).sum(:price) * @orders_quantity
    end
  end
end
