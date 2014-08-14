class AddRetailerNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :retailer_name, :integer
  end
end
