class HomeController < ApplicationController
	
	def index
	
	end

	def get_loyalty
		
	end

	def get_receipts

	end

	def post_receipt

		number_of_items = params["number_of_items"] || 3

		items = Item.all.order("RAND()").limit(number_of_items)

		items_array = []
		items.each do |item|
			items_array << {
				name: "#{item.name} (#{item.size})",
				quantity: 1,
				total: item.price,
				vat: {
					amount: ('%.2f' % [( (item.price / 1.2) * 100).round / 100.0]).to_f,
					rate: 20,
				},
				properties: {
					sku: item.sku,
					other_data: item.other_data
				},
			}
		end

		total = items.map{|t| t.price}.inject(:+)
 

		@receipt = {
			identifier: current_user.email,
			items: items_array, 
  			localtime: Time.now.iso8601, 
  			store_reference: 1, 
  			total: total, 
  			transaction_id: "#{rand(100000 .. 999999)}", 
		    vat: [
				      {
				        amount: ('%.2f' % [( (total / 1.2) * 100).round / 100.0]).to_f, 
				        rate: 20
				      }
		    		]
			}


		
	end

	def api_receipt_post
		@url = params["url"]
		@json = params["json"]
		

		@response = HTTParty.post(@url.to_str, :body =>@json, :headers => {'Content-Type' => 'application/json'})
		

		render "home/post_receipt_finish"
	end
	def api_email_post
		url = params["url"]
		json = params["json"]
		@response = HTTParty.post(url.to_str, :body =>json, :headers => {'Content-Type' => 'application/json'})
		render "home/receipt_posted"
		
	end

	def post_user
		
	end

	def post_loyalty
		
	end


end
