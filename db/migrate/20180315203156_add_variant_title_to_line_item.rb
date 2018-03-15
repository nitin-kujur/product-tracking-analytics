class AddVariantTitleToLineItem < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :variant_title, :string
  end
end
