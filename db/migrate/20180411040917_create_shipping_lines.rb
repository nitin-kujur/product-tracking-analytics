class CreateShippingLines < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_lines do |t|
      t.string :title
      t.decimal :price
      t.string :code
      t.string :source
      t.string :requested_fulfillment_service_id
      t.string :carrier_identifier
      t.json   :tax_lines, :array => true
      t.timestamps
    end
  end
end
