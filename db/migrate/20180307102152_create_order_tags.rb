class CreateOrderTags < ActiveRecord::Migration[5.1]
  def change
    create_table :order_tags do |t|
      t.timestamps
    end
  end
end
