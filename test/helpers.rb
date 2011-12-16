def assert_return_code_with_bin_equal return_code, scenario, bin
    kanagawa = Kanagawa.new(scenario,bin)

    assert_equal(return_code,kanagawa.run)
end

def assert_return_code_equal return_code, scenario
    kanagawa = Kanagawa.new(scenario)

    assert_equal(return_code,kanagawa.run)
end

