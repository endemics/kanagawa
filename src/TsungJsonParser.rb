#!/usr/bin/env ruby -rubygems

require 'json'

class TsungJsonParser
  def initialize
		@datas = Array.new
	end

	def add_json(string)
	end

	def status?
		return :break
	end
end
