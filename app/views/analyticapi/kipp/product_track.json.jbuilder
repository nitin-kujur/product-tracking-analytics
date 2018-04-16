json.products @product_track_arr do |product|
  json.sku product[:sku]
  json.product_name product[:product_name]
  json.unit_sold  product[:unit_sold]
  json.amount product[:amount]
  json.boh product[:boh]
  json.eoh product[:eoh]
end
