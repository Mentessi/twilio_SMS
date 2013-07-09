require 'minitest/autorun'
require 'minitest/mock'
require 'minitest/spec'
require '../lib/takeaway'


class TestTakeaway < MiniTest::Unit::TestCase

	def setup
		@customer = Takeaway.new
		@customer.create_menu({ :tikka=>5,
											:naan=>2.5,
											:rice=>2.5})
	end

	def test_menu_created
		assert_equal @customer.menu[:tikka], 5
	end

	def test_delete_menu
		@customer.delete_menu(@customer.menu)
		assert_equal @customer.menu, {}
	end

	def test_crop_number
		num = @customer.crop_number("07867482737")
		assert_equal num, 7867482737
	end

	def test_sum_order
		assert_equal @customer.sum_order({:tikka=>2,:rice=>2}), 15.0
	end

	def test_check_totals
		@customer.sum_order({:tikka=>2,:rice=>2})
		assert_raises(RuntimeError){@customer.check_totals(10)}
	end

	# def test_message_sent_for_valid_order
	# 	@customer.submit_order("07867482737",{:tikka=>2,:rice=>2}, 15.0)
	# 	assert_responds_to(message, sid) 
	# end

end


