require "open4"

class Kanagawa 
	def initialize(scenario, tsung_bin = "/usr/bin/tsung")
		@scenario = scenario
		@tsung_bin = tsung_bin
	end

	def run
		status = Open4::popen4(@tsung_bin) do |stdout, stderr, stdin, pid|
    end
		if status.exitstatus.nil? then
			return 1
		else 
			return status.exitstatus
		end
	end
end
