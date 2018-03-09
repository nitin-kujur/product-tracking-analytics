class CreateCustomerTags < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_tags do |t|
      
      t.timestamps
    end
  end
end
