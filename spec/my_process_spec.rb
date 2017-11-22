require "my_process"
require "dry-monads"

M = Dry::Monads

describe MyProcess do
	let(:args) { {dir: true, executed: false} }
	subject(:process) { MyProcess.new }
	context "when initialized" do

		describe "#call" do
			subject { process.call(**args) }
			it "returns a Status object" do
				expect(subject).to be_kind_of(Status)
			end

			it "the status should be properly populated" do
				expect(subject.dir).to be_truthy
				expect(subject.executed).to be_falsey
			end
			context "when dir when execute" do
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

				it "has to_s" do
					expect(subject.to_s).to eq("")
				end

				
			end
		end
		
	end

end
