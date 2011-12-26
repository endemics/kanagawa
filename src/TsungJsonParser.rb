require 'json'

class TsungJsonParser
  def initialize
		@datas = Array.new
	end

	def add_json(string)
		tmp=JSON.parse(string)
	  @datas << tmp
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
end
