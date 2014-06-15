class AddPropertiesToItems < ActiveRecord::Migration
  def change


  	add_column :items, :sku, :string
  	add_column :items, :other_data, :string
 

  end
end
