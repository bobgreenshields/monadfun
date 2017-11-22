require "my_process"
require "dry-monads"

M = Dry::Monads

describe MyProcess do
	let(:args) { {dir: true, executed: false} }
	subject(:process) { MyProcess.new }

	describe "#call" do
		subject { process.call(**args) }
		it "returns a Status object" do
			expect(subject).to be_kind_of(Status)
		end

		it "the status should be properly populated" do
			expect(subject.dir).to be_truthy
			expect(subject.executed).to be_falsey
		end

		context "when dir when executed" do
			let(:args) { {dir: true, executed: true} }

			it "has success" do
				expect(subject.success?).to be_truthy
			end

			it "events should have a DirFound object" do
				expect(subject.events[0]).to be_kind_of(DirFound)
			end

			it "events should have a ExecuteSuccess object" do
				expect(subject.events[1]).to be_kind_of(ExecuteSuccess)
			end
		end

		context "not dir but executed" do
			let(:args) { {dir: false, executed: true} }

			it "has no success" do
				expect(subject.success?).to be_falsey
			end

			it "has only one event" do
				expect(subject.events.count).to eql(1)
			end

			it "events should have a DirNotFound object" do
				expect(subject.events[0]).to be_kind_of(DirNotFound)
			end
		end

		context "when dir but not executed" do
			let(:args) { {dir: true, executed: false} }

			it "has no success" do
				expect(subject.success?).to be_falsey
			end

			it "has two events" do
				expect(subject.events.count).to eql(2)
			end

			it "events should have a DirFound object" do
				expect(subject.events[0]).to be_kind_of(DirFound)
			end

			it "events should have a ExecuteFailure object" do
				expect(subject.events[1]).to be_kind_of(ExecuteFailure)
			end
		end

	end

end
