require 'twilio-ruby'

class Takeaway

	attr_reader :menu

	def initialize
		@menu = {}
		@client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
	end
	
	ACCOUNT_SID = "ACbcebbf7e0b21eb8827b690a6fa8695ce"
	AUTH_TOKEN = "eff2cf3bda036f582c0315d82bcbbeb0"


	def create_menu(menu)
		@menu = menu
	end

	def delete_menu(menu)
		menu.clear
	end

	def submit_order(tel_num, order, customer_total_cost)
		crop_number(tel_num)
		sum_order(order)
		check_totals(customer_total_cost)
	end

	def sum_order(order)
		@actual_total_cost = 0
		order.each{|item,amount| @actual_total_cost += @menu[item] * amount}
		@actual_total_cost
	end

	def check_totals(customer_total_cost)
		if customer_total_cost == @actual_total_cost
			send_message
		else
			raise
		end
	end

	def crop_number(tel_num)
		@customer_tel_num = tel_num[1..-1].to_i
	end

	def send_message
		message = @client.account.sms.messages.create(:body => "Thank you, your order was place and will be with you before #{(Time.now + 3600).strftime("%H:%M")}",
    :to => "+44#{@customer_tel_num}",
    :from => "+441952783007")
		puts message.sid
	end

end





 
