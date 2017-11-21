require_relative "default_formatter"

class Status
	def initialize(formatter: DefaultFormatter.new)
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

	def each
		return enum_for(:each) unless block_given?
		@events.each { | event | yield event }
	end

end
