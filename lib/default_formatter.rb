class DefaultFormatter
	def call(status, events)
		if status.success?
			status_str = "This process has succeeded\n"
		else
			status_str = "This process has failed\n"
		end
		events_str = events.reverse.map(&:to_s).join("\n")
		status_str + events_str
	end
end
