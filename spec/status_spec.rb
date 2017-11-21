require "status"

describe Status do
	subject(:status) { Status.new }

	describe "#success?" do
		subject { status.success? }

		context "when first created" do
			it { is_expected.to be_truthy }	
		end

		context "when one of its events has failed" do
			before :each do
				status << Struct.new(:failure?).new(true)
			end

			it { is_expected.to be_falsey }	
		end
	end

	describe "#<<" do
		context "when events have been <<" do
			before :each do
				status << 1 << 2
			end

			it "they should be added to the array and yielded to #each" do
				expect { |b| status.each(&b) }.to yield_successive_args(1, 2)
				
			end
		end
	end
end
