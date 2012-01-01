require "src/Kanagawa"
require "test/unit"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_0_when_tsung_returns_0
		assert_kanagawa_return_code_equal(0,"test/fixtures/tsung_test_minimal.xml")
	end

	def test_return_1_when_remote_host_does_not_exist
		assert_kanagawa_return_code_equal(1,"test/fixtures/tsung_test_bad_remote_host.xml")
	end
	
	def test_return_1_when_tsung_returns_non_zero_code_or_fail_to_start
		assert_kanagawa_return_code_equal(1,"tsung_test_fail.xml")
	end
end

def assert_kanagawa_return_code_equal return_code, scenario
    kanagawa = Kanagawa.new(scenario)

    assert_equal(return_code,kanagawa.run)
end
