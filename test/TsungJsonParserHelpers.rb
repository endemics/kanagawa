def assert_status_code_equal return_code, json_data
		tsung_parser = TsungJsonParser.new()

		tsung_parser.add_json(json_data)

		assert_equal(return_code,tsung_parser.status?)
end


