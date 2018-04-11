class AdddTagToOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders,  :tags, :text
  end
end
