require "default_formatter"

describe DefaultFormatter do
	subject(:formatter) { DefaultFormatter.new }
	describe "#call" do
		context "when the status is successful" do
			let(:status) { Struct.new(:success?).new(true)	 }
			let(:success_str) { "This process has succeeded\n" }
			context "when it has no events" do
				let(:events) { [] }
				it "returns the succeeded string" do
					expect(formatter.call(status, events)).to eq success_str
				end
			end
			context "when it has events" do
				let(:events) { %w(one two three) }
				it "returns the success string and reversed events to_s joined by cr" do
					expected = success_str + events.reverse.join("\n")
					expect(formatter.call(status, events)).to eq expected
				end
			end
		end
		
		context "when the status has failed" do
			let(:status) { Struct.new(:success?).new(false)	 }
			let(:failed_str) { "This process has failed\n" }
			context "when it has no events" do
				let(:events) { [] }
				it "returns the failed string" do
					expect(formatter.call(status, events)).to eq failed_str
				end
			end
			context "when it has events" do
				let(:events) { %w(one two three) }
				it "returns the failed string and reversed events to_s joined by cr" do
					expected = failed_str + events.reverse.join("\n")
					expect(formatter.call(status, events)).to eq expected
				end
			end
		end
	end
end
