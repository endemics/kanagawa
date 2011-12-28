require "open4"
require "uuidtools"
require "../src/TsungJsonParser"

class Kanagawa 
	def initialize(scenario, tsung_bin = '/usr/bin/tsung')
		@scenario = scenario
		@tsung_bin = tsung_bin
		@tsung_parser = TsungJsonParser.new()
	end

	def run
		return 1 unless File.exist?(@scenario) 
		return 1 unless File.exist?(@tsung_bin)
		return 1 unless File.executable?(@tsung_bin)

		forced_stop = false
		uuid = UUIDTools::UUID.timestamp_create
		exec="#{@tsung_bin} -f - -m - -i #{uuid} start"
		status = Open4::popen4(exec) do |pid, stdin, stdout, stderr|
			#puts "[#{pid}] #{exec} < #{@scenario}"

			err_thread = Thread.new(stderr) do |stderr_lines|
				while (line = stderr_lines.gets)
	          puts "stderr: #{line}"
				end
			end

			out_thread = Thread.new(stdout) do |stdout_lines|
				while (line = stdout_lines.gets)
					@tsung_parser.add_string(line)
					if @tsung_parser.status? == :break
						Open4::popen4("#{@tsung_bin} -i #{uuid} stop")
						#puts "break requested ... stoping #{pid} with '#{@tsung_bin} -i #{uuid} stop'" 
						forced_stop = true
					end
				end
			end

			File.new(@scenario).each_line do |scenario_line|
				stdin.puts(scenario_line)
			end
			stdin.close

			err_thread.join
			out_thread.join
    end
		return_code = status.exitstatus.nil? ? 1 : status.exitstatus
		return_code = 1 if forced_stop

		return return_code 
	end
end
