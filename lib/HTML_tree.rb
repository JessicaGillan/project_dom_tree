class HTMLTree
  DOCTYPE = /<!\s*\w+\s*\w*>/
  attr_reader :root

  def initialize(dom)
    @dom = dom  # array of each line in a given html file
    @parser = Parser.new

    build_html_tree(dom)
    puts "Node count: #{@root.sub_tree_count}"
  end


  def build_html_tree(html_snippets)
    # Delete <!doctype html>
    html_snippets.delete_at(0) if html_snippets[0].match(DOCTYPE)

    # Parse each html snippet in to a tag
    tags =  html_snippets.map do |snippet|
              @parser.parse_tag(snippet)
            end

    # Set the root node and recursively add children
    # for each html_snippet by passing tags and current index
    @root ||= Node.new(tags[0])
    index = 0

    @root.add_child(tags, index + 1)
  end

  def node_count
    @root.sub_tree_count
  end

  def node_count_by_type
    @root.sub_tree_count_by_type
  end
end
