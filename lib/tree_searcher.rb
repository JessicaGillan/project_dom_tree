class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(key, value)
    matches = []

    @tree.root.bfs do |node|
      if node.tag.attributes.has_key? key
        if node.tag.attributes[key].include? value
          matches << node
        end
      end
    end

    matches
  end
end
