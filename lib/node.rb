Tag = Struct.new(:function, :type, :attributes)

class Node
  attr_reader :tag, :children
  attr_accessor :parent

  def initialize(tag, parent = nil, children = [])
    @tag = tag
    @parent = parent
    @children = children
  end

  def add_child(tags, index)
    return index if index >= tags.length
    return index if tags[index].function == :close

    if tags[index].function == :open
      n = Node.new(tags[index])
      index = n.add_child(tags, index + 1)
      n.parent = self
      @children << n
    else
      n = Node.new(tags[index])
      n.parent = self
      @children << n
    end

    self.add_child(tags, index + 1)
  end

  def sub_tree_count
    unless @sub_tree_count
      count = 0
      bfs { count += 1 }
      @sub_tree_count = count
    end
    @sub_tree_count
  end

  def sub_tree_count_by_type
    unless @sub_tree_count_by_type
      types = Hash.new(0)
      bfs { |node| types[node.tag.type] += 1 }
      @sub_tree_count_by_type = types
    end
    @sub_tree_count_by_type
  end

  # Breadth first search
  def bfs
    queue = [self]

    until queue.empty?
      current_node = queue.shift

      current_node.children.each do |child|
        queue << child
      end

      yield(current_node) if block_given?
    end
  end

  def inspect
    bfs do |node|
      print node
      print " PARENT: "
      print node.parent
      puts
    end
  end

  def to_s
    print "Function: #{@tag.function}, Type: #{@tag.type}, Attrs: #{@tag.attributes} ".ljust(30 )
  end
end
