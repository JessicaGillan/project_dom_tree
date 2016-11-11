require 'node_renderer'
require 'HTML_tree'
require 'parser'

describe NodeRenderer do
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
  let(:tree) { HTMLTree.new(data) }
  let(:renderer) { NodeRenderer.new(tree) }

  describe "#initialize" do
    it "takes in a tree" do
      expect{ NodeRenderer.new(tree) }.not_to raise_error
    end
  end

  describe "#render" do
    it "takes in a node" do
      expect{ renderer.render(tree.root) }.not_to raise_error
    end

    it "outputs statistics for the entire document if passed nil" do
      expect{ renderer.render }.not_to raise_error
    end

    it "outputs the number of nodes in the sub tree below the given node"
    it "outputs the count of each node type in the sub tree"
    it "outputs all of the given node's data attributes"
  end
end
