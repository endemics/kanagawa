require 'json'

class TsungJsonParser
  def initialize
		@datas = Array.new
	end

	# to add one line directly output from JSON tsung this function will cleanup the string before call of add_json
	def add_string(input)
		return 0 if input.nil?

		if input.include? "timestamp"
			# remove last ","
			input = input.sub(/,\s*$/, " ")
			# remove last "]}" they correspond to close of '{"stats": ['
			input = input.sub(/\}\]\}\]\}\s*$/, "}]}") unless input.nil?

			add_json(input)
		end
	end

	# to add one data burst in json format
	# one timestamp with samples : {"timestamp": XXXX,  "samples": [ .... ]} 
	def add_json(string)
		@datas << JSON.parse(string) unless string.nil?
	end

	def status?
		return_code = :ok

		@datas.last['samples'].each do |sample|
			if sample['name'] == 'error_connect_nxdomain' && sample['total'] >= 1
				return_code = :break
			end
		end

		return return_code
	end

	def count
		return @datas.count
	end
end
