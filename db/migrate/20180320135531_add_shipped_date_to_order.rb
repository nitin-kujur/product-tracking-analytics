class AddShippedDateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipped_date, :date
  end
end
