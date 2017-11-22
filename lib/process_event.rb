class ProcessEvent
	def initialize(*args)
		@str = build_str(*args)
	end

	def build_str(*args)
		args.count == 0 ? "" : args.join(" ")
	end

	def to_s
		@str
	end

	def success?
		true
	end

	def failure?
		! success?
	end
end

class ProcessFailure < ProcessEvent
	def success?
		false
	end
end
