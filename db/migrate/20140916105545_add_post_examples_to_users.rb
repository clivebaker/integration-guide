class AddPostExamplesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_examples, :boolean
  end
end
