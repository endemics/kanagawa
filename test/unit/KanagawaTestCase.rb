require "src/Kanagawa"
require "test/unit"

class KanagawaTestCase < Test::Unit::TestCase
	def test_return_1_when_tsung_mock_return_1
		assert_return_code_with_bin_equal(1,"tsung_test_fail.xml","/bin/false")
	end

	def test_return_1_when_tsung_returns_non_zero_code_or_fail_to_start
		assert_return_code_equal(1,"tsung_test_fail.xml")
	end

	def test_return_0_when_tsung_mock_returns_0
		assert_return_code_with_bin_equal(0,"test/fixtures/tsung_test_minimal.xml","bin/return_true")
	end

	def test_return_1_when_scenario_does_not_exist
		assert_return_code_equal(1,"tsung_test_not_exist.xml")
	end

	def test_return_1_when_tsung_does_not_exist
		assert_return_code_with_bin_equal(1,"test/fixtures/tsung_test_minimal.xml","this_file_does_not_exist")
	end

	def test_return_1_when_tsung_is_not_executable
		assert_return_code_with_bin_equal(1,"test/fixtures/tsung_test_minimal.xml","/etc/passwd")
	end

  def test_return_1_when_more_than_5_percent_of_transaction_take_more_than_1_second
  end
end

def assert_return_code_with_bin_equal return_code, scenario, bin
    kanagawa = Kanagawa.new(scenario,bin)

    assert_equal(return_code,kanagawa.run)
end

def assert_return_code_equal return_code, scenario
    kanagawa = Kanagawa.new(scenario)

    assert_equal(return_code,kanagawa.run)
end
