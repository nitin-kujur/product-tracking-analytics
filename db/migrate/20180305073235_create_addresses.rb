class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :order_id
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address1
      t.text :address2
      t.string :city
      t.string :province
      t.string :country
      t.string :country_name
      t.string :zip
      t.string :phone
      t.string :name
      t.string :province_code
      t.string :country_code
      t.boolean :default

      t.timestamps
    end
  end
end
