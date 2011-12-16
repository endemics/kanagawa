require "../src/Kanagawa"
require "test/unit"
require "helpers"

class KanagawaMocksTestCase < Test::Unit::TestCase
	def test_return_1_when_tsung_mock_return_1
		assert_return_code_with_bin_equal(1,"tsung_test_fail.xml","/bin/false")
	end

	def test_return_1_when_tsung_returns_non_zero_code_or_fail_to_start
		assert_return_code_equal(1,"tsung_test_fail.xml")
	end

	def test_return_0_when_tsung_mock_returns_0
		assert_return_code_with_bin_equal(0,"tsung_test_minimal.xml","../bin/return_true")
	end

	def test_return_1_when_scenario_does_not_exist
		assert_return_code_equal(1,"tsung_test_not_exist.xml")
	end

	def test_return_1_when_tsung_does_not_exist
		assert_return_code_with_bin_equal(1,"tsung_test_minimal.xml","this_file_does_not_exist")
	end

	def test_return_1_when_tsung_is_not_executable
		assert_return_code_with_bin_equal(1,"tsung_test_minimal.xml","/etc/passwd")
	end
end
