class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(key, value, node = @tree.root)
    matches = []

    node.bfs do |node|
      matches << node if has_attribute?(node, key, value)
    end

    matches
  end

  def search_descendents(node, key, value)
    search_by(key, value, node)
  end

  def search_ancestors(node, key, value)
    matches = []

    node.ancestor_search do |parent|
      matches << parent if has_attribute?(parent, key, value)
    end

    matches
  end

  def has_attribute?(node, key, value)
    node.tag.attributes.has_key?(key) &&
    node.tag.attributes[key].include?(value)
  end
end
