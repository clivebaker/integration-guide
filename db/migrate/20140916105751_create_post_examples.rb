class CreatePostExamples < ActiveRecord::Migration
  def change
    create_table :post_examples do |t|
      t.string :name
      t.text :json_string
      t.integer :user_id

      t.timestamps
    end
  end
end
