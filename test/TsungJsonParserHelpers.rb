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

