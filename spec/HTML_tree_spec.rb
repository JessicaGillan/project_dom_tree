require 'HTML_tree'
require 'Parser'

describe HTMLTree do
  let(:data) { ["<!doctype html>",
                "<div>",
                "div text before",
                "<p>",
                "p text",
                "</p>",
                "<div>",
                "more div text",
                "</div>",
                "div text after",
                "</div>"] }
  let(:nested_data) { [ "<!doctype html>",
                        "<p>",
                        "Before text",
                        "<span>",
                        "mid text (not included in text attribute of the paragraph tag)",
                        "</span>",
                        "after text.",
                        "</p>"] }
  let(:test_tree) { HTMLTree.new(data) }

  describe "#node_count" do
    it "has the correct number of total nodes" do

      expect(test_tree.node_count).to eq(7)
    end

    it "Can handle simple nested tags" do
      nested_tree = HTMLTree.new(nested_data)
      expect(nested_tree.node_count).to eq(5)
    end
  end

  describe "#node_count_by_type" do
    it "returns a hash" do
      expect(test_tree.node_count_by_type).to be_a Hash
    end

    it "returns correct number of nodes by type" do
      results = test_tree.node_count_by_type
      expect(results["div"]).to eq(2)
      expect(results["p"]).to eq(1)
      expect(results[nil]).to eq(4)
    end
  end
end
