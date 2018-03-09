class AddNameToCustomerTag < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_tags, :name, :string
  end
end
