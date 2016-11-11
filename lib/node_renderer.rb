class NodeRenderer
  def initialize(tree)
    @tree = tree
  end

  def render(node = nil)
    node ||= @tree.root

    render_data(node)
    render_sub_tree_count(node)
    render_sub_tree_count_by_type(node)
  end

  def render_data(node)
    puts
    puts "Node Data"
    puts node
    puts
  end

  def render_sub_tree_count(node)
    print "Number of nodes in sub-tree: "
    puts "#{node.sub_tree_count}"
    puts
  end

  def render_sub_tree_count_by_type(node)
    puts "Number of nodes in sub-tree by type "
    puts "  Type".ljust(10) + "Count".center(8)
    
    node.sub_tree_count_by_type.each do |type, count|
      type = !!type ? type : "content"
      puts "  #{type}".ljust(10) + "#{count}".center(8)
    end
  end
end
