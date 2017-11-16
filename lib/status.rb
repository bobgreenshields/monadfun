class Status
	def initialize
		@success = true
	end

	def success?
		@success
	end

	def fail
		@success = false	
	end
end
