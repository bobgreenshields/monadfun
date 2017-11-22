require "my_process"
require "dry-monads"

M = Dry::Monads

describe MyProcess do
	let(:args) { {dir: true, executed: false} }
	subject(:process) { MyProcess.new(**args) }
	context "when initialized" do
		it "the status should be properly populated" do
			expect(process.status.dir).to be_truthy
			expect(process.status.executed).to be_falsey
		end

		describe "#call" do
			subject { process.call }
			context "when dir" do
				let(:args) { {dir: true, executed: false} }

				it "should be right" do
					expect(subject.right?).to be_truthy
				end

				it "events should have a DirFound object" do
					expect(subject.value.events[0]).to be_kind_of(DirFound)
				end

				it "string to be good" do
					expect(subject.value.to_s).to eq("")
				end
				
			end
		end
		
	end

end
