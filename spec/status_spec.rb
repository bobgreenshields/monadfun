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
end
