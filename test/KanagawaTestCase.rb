require "../src/Kanagawa"
require "test/unit"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_1_when_tsung_return_1
		kanagawa = Kanagawa.new("tsung_test_fail.xml", "/bin/false")

		assert_equal(1,kanagawa.run)
	end

	def test_return_1_when_tsung_returns_non_zero_code_or_fail_to_start
		kanagawa = Kanagawa.new("tsung_test_fail.xml")

		assert_equal(1,kanagawa.run)
	end

	def test_return_0_when_tsung_returns_0
		kanagawa = Kanagawa.new("tsung_test_minimal.xml","/bin/true")

		assert_equal(0,kanagawa.run)
	end
end
