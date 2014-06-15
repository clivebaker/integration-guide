json.array!(@items) do |item|
  json.extract! item, :id, :name, :size, :price
  json.url item_url(item, format: :json)
end
