class AddLoyaltyProgramToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loyalty_program, :integer
  end
end
