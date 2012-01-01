require "src/TsungJsonParser"
require "test/unit"

class TsungJsonParserTestCase < Test::Unit::TestCase
	def test_status_return_break_when_error_connect_nxdomain_occurred
		json_data = '{"timestamp": 1324898796,  "samples": [
      {"name": "users", "value": 1, "max": 1},
   	  {"name": "users_count", "value": 1, "total": 1},
   	  {"name": "finish_users_count", "value": 0, "total": 0},
   	  {"name": "error_connect_nxdomain", "value": 1, "total": 1}]}'

		assert_add_json_status_code_equal(:break,json_data)
	end

	def test_status_return_ok_when_no_error_occurred
		json_data = '{"timestamp": 1324940879,  "samples": [   
			{"name": "users", "value": 0, "max": 1}, 
			{"name": "session", "value": 1, "mean": 228.4990234375,"stdvar": 0,"max":  228.4990234375,"min": 228.4990234375 ,"global_mean": 0 ,"global_count": 0}, 
			{"name": "users_count", "value": 1, "total": 1}, 
			{"name": "finish_users_count", "value": 1, "total": 1}, 
			{"name": "request", "value": 1, "mean": 185.360107421875,"stdvar": 0.0,"max":  185.360107421875,"min": 185.360107421875 ,"global_mean": 0 ,"global_count": 0}, 
			{"name": "page", "value": 1, "mean": 185.360107421875,"stdvar": 0.0,"max":  185.360107421875,"min": 185.360107421875 ,"global_mean": 0 ,"global_count": 0}, 
			{"name": "connect", "value": 1, "mean": 108.09619140625,"stdvar": 0.0,"max":  108.09619140625,"min": 108.09619140625 ,"global_mean": 0 ,"global_count": 0}, 
			{"name": "tr_01_root", "value": 1, "mean": 227.366943359375,"stdvar": 0,"max":  227.366943359375,"min": 227.366943359375 ,"global_mean": 0 ,"global_count": 0}, 
			{"name": "match", "value": 1, "total": 1}, 
			{"name": "http_200", "value": 1, "total": 1}, 
			{"name": "size_rcv", "value": 3666, "total": 3666}, 
			{"name": "size_sent", "value": 54, "total": 54}, 
			{"name": "connected", "value": 0, "max": 0}]}' 

		assert_add_json_status_code_equal(:ok,json_data)
	end

	def test_status_return_ok_when_no_data
		assert_add_json_status_code_equal(:ok,nil)
	end

	def test_tsung_parser_count_equal_0_when_adding_nil_data
		assert_when_adding_string_tsung_parser_count_equal(0, nil)
	end

	def test_tsung_parser_count_equal_0_when_adding_log_directory_line
		assert_when_adding_string_tsung_parser_count_equal(0, '"Log directory is: /home/tom/.tsung/log/20111227-0007"')
	end

	def test_tsung_parser_count_equal_0_when_adding_first_curly_brace
		assert_when_adding_string_tsung_parser_count_equal(0, '{ ')
	end

	def test_tsung_parser_count_equal_0_when_adding_stats
		assert_when_adding_string_tsung_parser_count_equal(0, '	 "stats": [')
	end

	def test_tsung_parser_count_equal_0_when_adding_empty_line
		assert_when_adding_string_tsung_parser_count_equal(0, ' ')
	end

	def test_tsung_parser_count_equal_1_when_adding_1_good_line
		assert_when_adding_string_tsung_parser_count_equal(1, '		  {"timestamp": 1324940864,  "samples": []},')
	end

	def test_tsung_parser_count_equal_2_when_adding_2_good_lines
		tsung_parser = TsungJsonParser.new()
		json_data_1 = '		  {"timestamp": 1324940864,  "samples": []},'
		json_data_2 = '		  {"timestamp": 1324940874,  "samples": [   {"name": "users", "value": 0, "max": 0}, {"name": "users_count", "value": 0, "total": 0}, {"name": "finish_users_count", "value": 0, "total": 0}]},'

		tsung_parser.add_string(json_data_1)
		tsung_parser.add_string(json_data_2)

		assert_equal(2,tsung_parser.count)
	end

	def test_tsung_parser_count_equal_1_when_adding_a_valid_last_line
		assert_when_adding_string_tsung_parser_count_equal(1, '			 {"timestamp": 1324940879,  "samples": [   {"name": "users", "value": 0, "max": 1}, {"name": "freemem", "hostname": "localhost", "value": 1, "mean": 2932.63671875,"stdvar": 0,"max": 2932.63671875,"min": 2932.63671875 ,"global_mean": 0 ,"global_count": 0}, {"name": "cpu", "hostname": "localhost", "value": 1, "mean": 2.246069378587472,"stdvar": 0,"max": 2.246069378587472,"min": 2.246069378587472 ,"global_mean": 0 ,"global_count": 0}, {"name": "load", "hostname": "localhost", "value": 1, "mean": 0.1015625,"stdvar": 0,"max": 0.1015625,"min": 0.1015625 ,"global_mean": 0 ,"global_count": 0}, {"name": "session", "value": 1, "mean": 228.4990234375,"stdvar": 0,"max":  228.4990234375,"min": 228.4990234375 ,"global_mean": 0 ,"global_count": 0}, {"name": "users_count", "value": 1, "total": 1}, {"name": "finish_users_count", "value": 1, "total": 1}, {"name": "request", "value": 1, "mean": 185.360107421875,"stdvar": 0.0,"max":  185.360107421875,"min": 185.360107421875 ,"global_mean": 0 ,"global_count": 0}, {"name": "page", "value": 1, "mean": 185.360107421875,"stdvar": 0.0,"max":  185.360107421875,"min": 185.360107421875 ,"global_mean": 0 ,"global_count": 0}, {"name": "connect", "value": 1, "mean": 108.09619140625,"stdvar": 0.0,"max":  108.09619140625,"min": 108.09619140625 ,"global_mean": 0 ,"global_count": 0}, {"name": "tr_01_root", "value": 1, "mean": 227.366943359375,"stdvar": 0,"max":  227.366943359375,"min": 227.366943359375 ,"global_mean": 0 ,"global_count": 0}, {"name": "match", "value": 1, "total": 1}, {"name": "http_200", "value": 1, "total": 1}, {"name": "size_rcv", "value": 3666, "total": 3666}, {"name": "size_sent", "value": 54, "total": 54}, {"name": "connected", "value": 0, "max": 0}, {"name": "error_abort", "value": 1, "total": 1}]}]}')
	end

	def test_tsung_parser_count_equal_1_when_adding_truncated_json_with_missing_end_curly_brace
		assert_when_adding_string_tsung_parser_count_equal(1,' {"timestamp": 1325003014,  "samples": [   {"name": "users", "value": 5, "max": 5}, {"name": "freemem", "hostname": "localhost", "value": 1, "mean": 2751.1640625,"stdvar": 0.0,"max": 2751.22265625,"min": 2750.48046875 ,"global_mean": 2750.9388020833335 ,"global_count": 3}, {"name": "cpu", "hostname": "localhost", "value": 1, "mean": 0.5744255744255744,"stdvar": 0.0,"max": 1.6504126031507877,"min": 0.24968789013732834 ,"global_mean": 0.8081920059212137 ,"global_count": 3}, {"name": "load", "hostname": "localhost", "value": 1, "mean": 0.0,"stdvar": 0.0,"max": 0.0,"min": 0.0 ,"global_mean": 0.0 ,"global_count": 3}, {"name": "users_count", "value": 0, "total": 5}, {"name": "finish_users_count", "value": 0, "total": 0}, {"name": "error_connect_nxdomain", "value": 5, "total": 15}')
	end

	def test_tsung_parser_count_equal_1_when_adding_truncated_json_with_missing_end_square_bracket_and_curly_brace
		assert_when_adding_string_tsung_parser_count_equal(1,' {"timestamp": 1325004682,  "samples": [')
	end
end

def assert_add_json_status_code_equal return_code, json_data
  tsung_parser = TsungJsonParser.new()

  tsung_parser.add_json(json_data)

  assert_equal(return_code,tsung_parser.status?)
end

def assert_when_adding_string_tsung_parser_count_equal count, string
  tsung_parser = TsungJsonParser.new()

  tsung_parser.add_string(string)
      
  assert_equal(count,tsung_parser.count)
end
