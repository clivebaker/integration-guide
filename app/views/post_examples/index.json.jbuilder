json.array!(@post_examples) do |post_example|
  json.extract! post_example, :id, :name, :json_string, :user_id
  json.url post_example_url(post_example, format: :json)
end
