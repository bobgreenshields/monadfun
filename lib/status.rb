class Status
	def initialize
		@success = true
		@events = []
	end

	def success?
		@success
	end

	def fail
		@success = false	
	end
end
