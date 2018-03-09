class CreateCustomerCustomerTags < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_customer_tags do |t|
      t.integer :customer_id
      t.integer :customer_tag_id

      t.timestamps
    end
  end
end
