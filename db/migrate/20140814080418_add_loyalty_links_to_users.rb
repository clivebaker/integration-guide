class AddLoyaltyLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loyalty_links, :boolean
  end
end
