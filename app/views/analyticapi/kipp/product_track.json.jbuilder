json.products @product_track_arr do |product|
  json.sku product.sku
  json.product_name product.title 
  json.unit_sold  product.quantity
  json.amount product.total_price
  json.boh product.inventory_quantity
  json.eoh product.eoh 
end
