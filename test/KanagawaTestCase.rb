require "../src/Kanagawa"
require "test/unit"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_1_when_tsung_mock_return_1
		assert_return_code_equal(1,"tsung_test_fail.xml","/bin/false")
	end

	def test_return_1_when_tsung_returns_non_zero_code_or_fail_to_start
		kanagawa = Kanagawa.new("tsung_test_fail.xml")

		assert_equal(1,kanagawa.run)
	end

	def test_return_0_when_tsung_mock_returns_0
		assert_return_code_equal(0,"tsung_test_minimal.xml","../bin/return_true")
	end

	def test_return_1_when_scenario_does_not_exist
		kanagawa = Kanagawa.new("tsung_test_not_exist.xml")

		assert_equal(1,kanagawa.run)
	end

	def test_return_0_when_tsung_returns_0
		kanagawa = Kanagawa.new("tsung_test_minimal.xml")
		
		assert_equal(0,kanagawa.run)
	end
end

def assert_return_code_equal return_code, scenario, bin
		kanagawa = Kanagawa.new(scenario,bin)

		assert_equal(return_code,kanagawa.run)
end

