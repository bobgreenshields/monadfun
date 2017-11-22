require_relative "status"
require_relative "process_event"
require "dry-monads"

class DirFound < ProcessEvent
	def build_str(*args)
		dir, * = args
		"[SUCCESS]   Directory #{dir} was found"
	end
end

class DirNotFound < ProcessFailure
	def build_str(*args)
		dir, * = args
		"[FAILURE]   Directory #{dir} could not be found"
	end
end

class MyStatus < Status
	attr_reader :dir, :executed

	def initialize(dir:, executed:)
		@dir = dir
		@executed = executed
	end
end



class MyProcess
	include Dry::Monads::Either::Mixin

	attr_reader :status

	def initialize(dir:, executed:)
		@status = MyStatus.new(dir: dir, executed: executed)
	end

	def call
		dir_path = "/home/bobg/test/dir"
		Right(@status).bind do | status |
			if status.dir
				Right(status << DirFound.new(dir_path))
			else
				Left(status << DirNotFound.new(dir_path))
			end
		end
		
	end
	
	
end
