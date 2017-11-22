require "process_event"

describe ProcessFailure do
	let(:args) { [] }
	subject(:event) { ProcessFailure.new(*args) }
	describe "#success?" do
		subject { event.success? }
		it { is_expected.to be_falsey }
	end

	describe "#failure?" do
		subject { event.failure? }
		it { is_expected.to be_truthy }
	end
	
	describe "#to_s" do
		subject { event.to_s }
		context "with no args" do
			it { is_expected.to eq("") }
		end
		context "with args" do
			let(:args) { %w(one two three) }
			it "joins the args with spaces" do
				expect(subject).to eq("one two three")
			end
		end
	end
end
