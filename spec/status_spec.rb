require "status"

describe Status do
	describe "#success?" do
		context "when first created" do
			it "should be true" do
				status = Status.new
				expect(status.success?).to be_truthy
			end
		end

		context "when fail has been called" do
			it "should be false" do
				status = Status.new
				status.fail
				expect(status.success?).to be_falsey
			end
		end
	end
end
