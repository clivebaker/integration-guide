#coding: utf-8

@config = YAML::load(File.open(File.join(Rails.root.to_s, 'config', 'database.yml')))[Rails.env.to_s.downcase]


namespace :monsoon do

	def receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments, employee_sale=nil, monsoon_reward_card=nil)
		
		total = 0
		discount = 0
		# = items.map{|t| t[:total]}.inject(:+) 
	#	discount = items.map{|t| t[:discounts] }.inject(:+)
		items.each do |item|
				total += item[:total]
				if item[:discounts]
					item[:discounts].each do |dis|
						discount += dis[:amount]
					end
				end

		end
		

		receipt = {
			identifier: identifier,
			items: items, 
  			localtime: datetime.iso8601 , 
  			store_reference: 1, 
  			total: total + discount, 
  			transaction_id: transaction_id, 
		    vat: [
				      {
				        amount: 0, 
				        rate: 0
				      }
		    		],
		    properties: {
		    	transaction_details: {
		    	date: datetime.iso8601,
		    	till: till,
		    	tran: transaction_number,
		    	store: store,
		    	time: "#{datetime.strftime("%H:%M")}"
		    	},
		    	salesperson: salesperson
		    },
		    payments: payments
			}


			receipt[:properties][:employee_sale] = employee_sale if employee_sale
			receipt[:properties][:monsoon_reward_card] = monsoon_reward_card if monsoon_reward_card

		receipt

	end


def item(name, total, product_code, mmg, additional_properties={},discount=nil)

		item  =	{
				name: name,
				quantity: 1,
				total: total,
				vat: {
					amount: 0,
					rate: 0,
				},
				properties: {
					product_code: product_code,
					mmg: mmg,
				},
			}
		additional_properties.keys.each do |key|
			item[:properties][key] = additional_properties[key]
		end
		item[:discounts] = discount if discount


		item

end

	desc "Create receipt 1"
	task :receipt1 => :environment do |task, args| 
		


			payments = [
		    	{
		    		amount: -90.0, 
		    		method: "cash", 
		    		details: {
		    			change: 1.0
		    			}
		    	}
		    ]

		
		items = []
		items << item("Cara Padded Coat", 89, "6490025552", "XMDOCP")

		transaction_id = "00100910018415140913102437"
		transaction_number = "8415"
		datetime = Time.parse("2014-09-13 10:24:37")
		identifier = "email@emaildomain.com"
		till = "1001"
		store = 1
		salesperson = "100903"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(1)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"
	end


	desc "Create receipt 2"
	task :receipt2 => :environment do |task, args| 

			payments = [
		    	{
		    		amount: -5, 
		    		method: "card", 
		    		details: {
		    			type: "accessorize uk gift card",
		    			number: "2371",
		    			other: {
		    				previous_balance: 5,
		    				new_balance: 0
		    					}
		    				}
		    	},{
		    		amount: -1, 
		    		method: "cash", 
		    		details: {
		    			change: 0.5
		    			}
		    	}
		    ]

		
		items = []
		items << item("FF Infinity Pendant", 4, "5822078100", "XAJNDP")
		items << item("Ditsy Floral Tissues", 1.5, "6996719900", "XALPAB")

		transaction_id = "00100910031335140830151542"
		transaction_number = "1335"
		datetime = Time.parse("2014-08-30 15:15:42")
		identifier = "email@emaildomain.com"
		till = "1003"
		store = 1
		salesperson = "100907"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(2)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end

	desc "Create receipt 3"
	task :receipt3 => :environment do |task, args| 

			payments = [
		    	{
		    		amount: 32, 
		    		method: "card", 
		    		details: {
		    			number: "4008"
		    		}
		    	},{
		    		amount: 30, 
		    		method: "card", 
		    		details: {
		    			type: "monsoon uk merchant return",
		    			number: "2814",
		    				other: {
		    					previous_balance: 0,
		    					new_balance: 30
		    					}
		    				}
		    	}
		    ]

		
		items = []
		items << item("Fleur Dress", -45, "6450728308", "XMBFDK", {returned: true,  comment: "Saleable - No fault found"})
		items << item("MOP Shell Flower Nk", -17, "6820193500", "XAJNDR", {returned: true,  comment: "Saleable - No fault found"})

		transaction_id = "00100910018375140911133038"
		transaction_number = "8375"
		datetime = Time.parse("2014-09-11 13:30:38")
		identifier = "email@emaildomain.com"
		till = "1001"
		store = 1
		salesperson = "100907"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(3)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end

	desc "Create receipt 5"
	task :receipt5 => :environment do |task, args| 

			payments = [
				{
		    		amount: -4, 
		    		method: "card", 
		    		details: {
		    			type: "employee card",
		    			number: "4322",
		    				other: {
		    					remaining_balance: 340
		    					}
		    				}
		    	}
		    ]

		
		items = []
		items << item("PastelCableiPhone5", 8, "6998747000", "XALPAE", {}, [{name:"Discount 50% - Employee Discount", qualtity: 1, amount: -4}])
	
		transaction_id = "00411110071076140901093717"
		transaction_number = "1076"
		datetime = Time.parse("2014-09-01 09:37:17")
		identifier = "email@emaildomain.com"
		till = "1007"
		store = 1
		salesperson = "411189"

		employee_sale = {
			employee_id: 3033927,
			employee_name: "Rebecca Louise Smith",
			account_starting_balance: 348
		}


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments, employee_sale)

		pe = PostExample.find(5)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end



	desc "Create receipt 7"
	task :receipt7 => :environment do |task, args| 

			payments = [
				{
		    		amount: -213, 
		    		method: "card", 
		    		details: {
		    			type: "AMEX",
		    			number: "7002"
		    				}
		    	}
		    ]

		
		items = []
		items << item("Ava Dress", 139, "7451676122", "XMODDK")
		items << item("Jeanie Linen Trouser", 39, "5630221318", "XMNBPT", {}, [{name:"Discount £10.00 - Company Markdown", qualtity: 1, amount: -10}])
		items << item("Tilly Tregging ", 45, "6460190120", "XMDCTY")
	
		transaction_id = "00411110093760140915113625"
		transaction_number = "3760"
		datetime = Time.parse("2014-09-15 11:36:25")
		identifier = "email@emaildomain.com"
		till = "1009"
		store = 1
		salesperson = "411178"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(7)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end


	desc "Create receipt 8"
	task :receipt8 => :environment do |task, args| 

			payments = [
				{
		    		amount: -35.1, 
		    		method: "card", 
		    		details: {
		    			type: "student card",
		    			number: "1728"
		    				}
		    	}
		    ]

		
		items = []
		items << item("Laura Double Pocket", 39, "6892783500", "XABBDI", {}, [{name:"Discount 10% - Student Discount", qualtity: 1, amount: -3.9}])
	
		transaction_id = "00411110058749140901104615"
		transaction_number = "8749"
		datetime = Time.parse("2014-09-01 10:46:15")
		identifier = "email@emaildomain.com"
		till = "1005"
		store = 1
		salesperson = "411122"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(8)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end



	desc "Create receipt 9"
	task :receipt9 => :environment do |task, args| 

			payments = [
				{
		    		amount: -15, 
		    		method: "card", 
		    		details: {
		    			type: "monsoon uk gift card",
		    			number: "6257",
		       			other: {
		    				previous_balance: 19,
		    				new_balance: 4
		    					}
		    				}
		    	}
		    ]

		
		items = []
		items << item("Ava Pearl and Crysta", 15, "6840451300", "XAJBBG")
	
		transaction_id = "00102310065316140913102312"
		transaction_number = "5316"
		datetime = Time.parse("2014-09-13 10:23:12")
		identifier = "email@emaildomain.com"
		till = "1006"
		store = 1
		salesperson = "102304"


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments)

		pe = PostExample.find(9)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end

                                  
	desc "Create receipt 10"
	task :receipt10 => :environment do |task, args| 

			payments = [
				{
		    		amount: -9, 
		    		method: "card", 
		    		details: {
		    			number: "8149"
		    				}
		    	}
		    ]

		
		items = []
		items << item("120 Denier Tights", 9, "5432570161", "XMAATT")
	
		transaction_id = "00100910018357140910100604"
		transaction_number = "8357"
		datetime = Time.parse("2014-09-10 10:06:04")
		identifier = "email@emaildomain.com"
		till = "1001"
		store = 1
		salesperson = "100902"


		monsoon_reward_card = {
			number: "80704020730052303599"
		}


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments, nil, monsoon_reward_card)

		pe = PostExample.find(10)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end


	desc "Create receipt 11"
	task :receipt11 => :environment do |task, args| 

			payments = [
				{
		    		amount: 65, 
		    		method: "card", 
		    		details: {
		    			number: "1738"
		    				}
		    	}
		    ]

		
		items = []
		items << item("Carmen Ruffle Dress", -55, "5586453953", "XKGPDD", {returned: true,  comment: "Web return - Not as described"})
		items << item("Lotte Peterpan Colla", -24, "6182330253", "XKGDDW", {returned: true,  comment: "Web return - Too Big"})
		items << item("Sparkle Tweed Short", -20, "6181272053", "XKGDRW", {returned: true,  comment: "Web return - The Style does not suit"})
		items << item("Check Tweed Short", -20, "6181352453", "XKGDRW", {returned: true,  comment: "Web return - The Style does not suit"})
		items << item("Sparkle Tweed Blazer", -34, "6181252029", "XKGOCC", {returned: true,  comment: "Web return - The Style does not suit"})
		items << item("Niamh Cardigan", 20, "6381421129", "XKGPCL")
		items << item("2 Pack Plain Tights", 10, "6163304127", "XKAATD")
		items << item("Cable Tights", 8, "6165040629", "XKAATD")
		items << item("Perlato Butterfly An", 7, "6160482629", "XKAATP")
		items << item("Flower Heart Net Nyl", 7, "6160492629", "XKAATP")
		items << item("Butterfly Cardigan", 18, "6381380629", "XKGDCK")
		items << item("Rara Check Skirt", 18, "6182731629", "XKGDSW")

	
		transaction_id = "00100910018417140913113304"
		transaction_number = "8417"
		datetime = Time.parse("2014-09-10 10:06:04")
		identifier = "email@emaildomain.com"
		till = "1001"
		store = 1
		salesperson = "100902"


		monsoon_reward_card = {
			number: "80704020730052303599"
		}


		receipt = receipt(identifier, items, datetime, transaction_id, transaction_number, till, store, salesperson, payments, nil, monsoon_reward_card)

		pe = PostExample.find(11)
		pe.json_string = receipt.to_json
		pe.save

		puts receipt.to_json
		puts "SAVED!!!!"

	end





  
                                  
                              
  
                              

  








end