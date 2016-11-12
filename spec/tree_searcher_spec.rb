require 'tree_searcher'
require 'HTML_tree'
require 'Parser'

describe TreeSearcher do
  let(:data) { ["<!doctype html>",
                "<div class='parent testing'>",
                  "div text before",
                  "<p class='sibling testing'>",
                    "p text",
                  "</p>",
                  "<div class='immediate parent'>",
                    "more div text", # Testing node
                  "</div>",
                  "div text after",
                "</div>"] }
  let(:attr_data) { ["<h1 id='dolphin bluewhale shark' class='animal amphibian foo' draggable='false'>",
              "<p class='foo bar' id='baz' name='fozzie'>"] }
  let(:tree) { HTMLTree.new(data) }
  let(:attr_tree) { HTMLTree.new(attr_data) }
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
      class_searcher = TreeSearcher.new(attr_tree)
      expect(class_searcher.search_by(:class, 'animal').length).to eq 1
      expect(class_searcher.search_by(:class, "foo").length).to eq 2
      expect(searcher.search_by(:text, "more div text").length).to eq 1
    end
  end

  describe "#search_descendents" do
    it "searches all the descendents of a given node" do
      class_searcher = TreeSearcher.new(attr_tree)
      expect(class_searcher.search_descendents(attr_tree.root, :class, 'animal').length).to eq 1
      expect(class_searcher.search_descendents(attr_tree.root, :class, "foo").length).to eq 2
    end
  end

  describe "#search_ancestors" do
    it "searches the ancestors of a given node" do
      node = searcher.search_by(:text, "more div text")[0]
      # expect(searcher.search_ancestors(node, :class, "testing").length).to eq 1
      expect(searcher.search_ancestors(node, :class, "parent").length).to eq 2
    end
  end
end
