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

class ExecuteSuccess < ProcessEvent
	def build_str(*args)
		"[SUCCESS]   the execution was successful"
	end
end

class ExecuteFailure < ProcessFailure
	def build_str(*args)
		"[FAILURE]   the execution failed"
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

	def find_dir
		dir_path = "/home/bobg/test/dir"

		->(status) do
			if status.dir
				Right(status << DirFound.new(dir_path))
			else
				Left(status << DirNotFound.new(dir_path))
			end
		end
	end

	def do_execute
		->(status) do
			if status.executed
				Right(status << ExecuteSuccess.new)
			else
				Left(status << ExecuteFailure.new)
			end
		end
	end

	def call(dir:, executed:)
#		status = MyStatus.new(dir: dir, executed: executed)
		Right(MyStatus.new(dir: dir, executed: executed)).
			bind(find_dir).
			bind(do_execute).
			value
	end
	
	
end
