require "../src/TsungJsonParser"
require "test/unit"
require "TsungJsonParserHelpers"

class TsungJsonParserTestCase < Test::Unit::TestCase
	def test_status_return_break_when_error_connect_nxdomain_occurred
		json_data = '{"timestamp": 1324898796,  "samples": [
      {"name": "users", "value": 1, "max": 1},
   	  {"name": "users_count", "value": 1, "total": 1},
   	  {"name": "finish_users_count", "value": 0, "total": 0},
   	  {"name": "error_connect_nxdomain", "value": 1, "total": 1}]}'

		assert_status_code_equal(:break,json_data)
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

		assert_status_code_equal(:ok,json_data)
	end

	def test_do_nothing_when_add_nil_data
		tsung_parser = TsungJsonParser.new()
		tsung_parser.add_json(nil)
		assert_equal(0,tsung_parser.count)
	end
end
