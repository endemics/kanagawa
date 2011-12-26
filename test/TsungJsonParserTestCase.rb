require "../src/TsungJsonParser"
require "test/unit"
require "helpers"

class TsungJsonParserTestCase < Test::Unit::TestCase
	def test_status_return_break_when_error_connect_nxdomain_ocure
		tsung_parser = TsungJsonParser.new()
		json_data = '{"timestamp": 1324898796,  "samples": [
      {"name": "users", "value": 1, "max": 1},
   	  {"name": "users_count", "value": 1, "total": 1},
   	  {"name": "finish_users_count", "value": 0, "total": 0},
   	  {"name": "error_connect_nxdomain", "value": 1, "total": 1}]}'
		tsung_parser.add_json(json_data)
		assert_equal(:break,tsung_parser.status?)
	end
end
