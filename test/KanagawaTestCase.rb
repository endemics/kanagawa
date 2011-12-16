require "../src/Kanagawa"
require "test/unit"
require "helpers"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_0_when_tsung_returns_0
		assert_return_code_equal(0,"tsung_test_minimal.xml")
	end
end
