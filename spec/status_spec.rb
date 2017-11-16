require "status"

describe Status do
	subject(:status) { Status.new }

	describe "#success?" do
		subject { status.success? }

		context "when first created" do
			it { is_expected.to be_truthy }	
		end

		context "when fail has been called" do
			before :each do
				status.fail
			end
			it { is_expected.to be_falsey }	
		end
	end
end
