require_relative "default_formatter"

class Status
	def initialize(formatter: DefaultFormatter.new)
		@events = []
		@formatter = formatter
	end

	def failure?
		@events.any? { |event| event.failure? }
	end

	def success?
		! failure?
	end

	def <<(event)
		@events << event
		self
	end

	def each
		return enum_for(:each) unless block_given?
		@events.each { | event | yield event }
	end

	def to_s
		@formatter.call(self, @events)
	end

end
