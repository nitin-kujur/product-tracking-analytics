class AddSchoolToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :school, :string
  end
end
