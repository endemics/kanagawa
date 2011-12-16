require "../src/Kanagawa"
require "test/unit"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_1_when_tsung_fails_to_run
		#Given
		kanagawa = Kanagawa.new("tsung_test_fail.xml")

		#Then	
		assert_equal(1,kanagawa.run)
	end
end
