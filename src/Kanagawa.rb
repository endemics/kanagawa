require "open4"
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

		exec="#{@tsung_bin} -f - -m - start"
		status = Open4::popen4(exec) do |pid, stdin, stdout, stderr|
			err_thread = Thread.new(stderr) do |stderr_lines|
				while (line = stderr_lines.gets)
	          puts "stderr: #{line}"
				end
			end

			out_thread = Thread.new(stdout) do |stdout_lines|
				while (line = stdout_lines.gets)
					#@tsung_parser.add_json(line)
					#if @tsung_parser.status? == :break
					#	Process.kill 15, pid 
					#	puts "killing  #{pid}" 
					#end
				end
			end

			File.new(@scenario).each_line do |scenario_line|
				stdin.puts(scenario_line)
			end
			stdin.close

			err_thread.join
			out_thread.join
    end
		status.exitstatus.nil? ? 1 : status.exitstatus
	end
end
