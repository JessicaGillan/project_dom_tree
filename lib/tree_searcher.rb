class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(key, value, node = @tree.root)
    matches = []

    node.bfs do |node|
      if node.tag.attributes.has_key? key
        if node.tag.attributes[key].include? value
          matches << node
        end
      end
    end

    matches
  end

  def search_descendents(node, key, value)
    search_by(key, value, node)
  end

  def search_ancestors(node, key, value)
    matches = []

    parents = node.ancestor_search

    parents.each do |node|
      if node.tag.attributes.has_key? key
        if node.tag.attributes[key].include? value
          matches << node
        end
      end
    end

    matches
  end

  def search_proc
    # How do you do this??
  end
end
