class AddValueToCustomerTag < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_tags, :value, :string
  end
end
