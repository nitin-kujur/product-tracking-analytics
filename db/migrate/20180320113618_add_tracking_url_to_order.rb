class AddTrackingUrlToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :tracking_url, :text
  end
end
