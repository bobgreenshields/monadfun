class Status
	def initialize
		@success = true
		@events = []
	end

	def failure?
		@events.any? { |event| event.failure? }
	end

	def success?
		! failure?
	end

	def << (event)
		@events << event
	end

end
