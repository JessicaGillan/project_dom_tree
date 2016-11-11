class HTMLTree
  attr_reader :root

  def initialize(dom)
    @dom = dom  # array of each line in a given html file
    @parser = Parser.new

    build_html_tree(dom)
  end


  def build_html_tree(html_snippets)
    # Parse each html snippet in to a tag
    tags =  html_snippets.map do |snippet|
              @parser.parse_tag(snippet)
            end

    # Set the root node and recursively add children
    # for each html_snippet by passing tags and current index
    @root ||= Node.new(tags[1]) # Skip <!doctype html>
    index = 1

    @root.add_child(tags, index + 1)
  end

  def node_count
    @root.sub_tree_count
  end

  def node_count_by_type
    @root.sub_tree_count_by_type
  end
end
