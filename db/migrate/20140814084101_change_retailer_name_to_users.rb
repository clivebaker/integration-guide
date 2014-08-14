class ChangeRetailerNameToUsers < ActiveRecord::Migration
  def change

  	change_column :users, :retailer_name, :string

  end
end
