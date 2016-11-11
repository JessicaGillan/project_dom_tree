require 'tree_searcher'
require 'HTML_tree'
require 'Parser'

describe TreeSearcher do
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
  let(:searcher) { TreeSearcher.new(tree) }

  describe "#initialize" do
    it "takes a tree" do
      expect{ TreeSearcher.new(tree) }.not_to raise_error
    end
  end

  describe "#search_by" do
    it "takes an attribute key and value to search for" do
      expect{ searcher.search_by(:class, "rocky") }.not_to raise_error
    end

    it "returns a collection of nodes" do
      expect(searcher.search_by(:class, "rocky")).to be_an Array
    end

    it "returns a collection of all the nodes that exactly match the search criteria" do
      
    end
  end

  describe "#search_descendents" do
    it "searches all the descendents of a given node"
  end

  describe "#search_ancestors" do
    it "searches the ancestors of a given node"
  end
end

# Search for and return a collection with all nodes exactly matching
# the name, text, id, or class provided, e.g:
#
# Search only the descendents (nodes "lower" in the tree)
# of a particular node, e.g:
#
# Search just the direct ancestors of a particular node in similar ways, e.g.:
