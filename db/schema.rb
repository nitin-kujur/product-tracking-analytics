# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180320113618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "order_id"
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "address1"
    t.text "address2"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "country_name"
    t.string "zip"
    t.string "phone"
    t.string "name"
    t.string "province_code"
    t.string "country_code"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_type"
  end

  create_table "customer_customer_tags", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "customer_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.string "name"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "shop_id"
    t.string "first_name"
    t.string "last_name"
    t.string "shopify_customer_id"
    t.string "email"
    t.float "total_spent"
    t.integer "orders_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.string "shopify_vaiant_id"
    t.string "shopify_line_item_id"
    t.string "variant_id"
    t.text "title"
    t.integer "quantity"
    t.decimal "price"
    t.string "sku"
    t.string "fulfillment_service"
    t.string "shopify_product_id"
    t.boolean "requires_shipping"
    t.json "properties", array: true
    t.integer "fulfillable_quantity"
    t.decimal "total_discount"
    t.string "fulfillment_status"
    t.json "origin_location"
    t.json "destination_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "variant_title"
  end

  create_table "order_order_tags", force: :cascade do |t|
    t.integer "order_id"
    t.integer "order_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.string "name"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "customer_id"
    t.string "shopify_order_id"
    t.string "email"
    t.datetime "closed_at"
    t.datetime "shopify_created_at"
    t.datetime "shopify_updated_at"
    t.integer "number"
    t.decimal "total_price"
    t.decimal "subtotal_price"
    t.float "total_weight"
    t.float "total_tax"
    t.string "financial_status"
    t.decimal "total_line_items_price"
    t.datetime "cancelled_at"
    t.text "cancel_reason"
    t.string "user_id"
    t.datetime "processed_at"
    t.string "order_number"
    t.string "fulfillment_status"
    t.string "contact_email"
    t.integer "billing_address_id"
    t.integer "shipping_address_id"
    t.string "shopify_customer_id"
    t.string "customer_email"
    t.string "order_region"
    t.datetime "deleted_at"
    t.string "discount_codes"
    t.integer "deleted_by"
    t.string "client_details"
    t.string "parent_order_id"
    t.string "parent_customer_id"
    t.string "shopify_tracking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount"
    t.string "parent_order_flag"
    t.text "tracking_url"
  end

  create_table "orders_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_product_tags", force: :cascade do |t|
    t.integer "product_id"
    t.integer "product_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "value"
  end

  create_table "products", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "Number_of_orders"
    t.string "title"
    t.string "product_type"
    t.string "vendor"
    t.string "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_product_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name"
    t.string "shopify_domain"
    t.string "shop_private_api_keys"
    t.string "shop_private_api_secret"
    t.string "shop_private_api_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_token"
    t.string "shop_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "product_id"
    t.string "shopify_product_id"
    t.string "title"
    t.string "sku"
    t.string "inventory_policy"
    t.string "position"
    t.integer "inventory_quantity"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_variant_id"
  end

end
