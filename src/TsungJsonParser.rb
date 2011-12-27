require 'json'

class TsungJsonParser
  def initialize
		@datas = Array.new
	end

	# to add one data burst in json format
	# one timestamp with samples : {"timestamp": XXXX,  "samples": [ .... ]} 
	def add_json(string)
		if ! string.nil?
			tmp=JSON.parse(string) 
			@datas << tmp
		end
	end

	def status?
		return_code = :ok

		@datas.last['samples'].each { |sample|
			if sample['name'] == 'error_connect_nxdomain' && sample['total'] >= 1
				return_code = :break
			end
		}

		return return_code
	end

	def count
		return @datas.count
	end
end
