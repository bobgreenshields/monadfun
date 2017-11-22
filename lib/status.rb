require_relative "default_formatter"

class Status
	attr_accessor :formatter

	def failure?
		events.any? { |event| event.failure? }
	end

	def success?
		! failure?
	end

	def <<(event)
		events << event
		self
	end

	def each
		return enum_for(:each) unless block_given?
		events.each { | event | yield event }
	end

	def to_s
		formatter.call(self, events)
	end

	def formatter
		@formatter ||= DefaultFormatter.new
	end

	def events
		@events ||= []
	end

end
