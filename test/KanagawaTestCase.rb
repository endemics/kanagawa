require "../src/Kanagawa"
require "test/unit"
require "KanagawaHelpers"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_0_when_tsung_returns_0
		assert_return_code_equal(0,"tsung_test_minimal.xml")
	end

	def test_return_1_when_remote_host_does_not_exist
		assert_return_code_equal(1,"tsung_test_bad_remote_host.xml")
	end

end
