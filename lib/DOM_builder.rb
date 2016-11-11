class DOMBuilder

  def build_from_tree(tree)
    stream = "<!doctype html>\n"

    tree.root.dfs do |node|
      tag = node.tag

      case tag.function
      when :open, :open_close
        stream << "<#{tag.type}"
        unless tag.attributes.empty?
          tag.attributes.each do |key, values|
            stream << " #{key}='"
            values.each do |value|
              stream << "#{value} "
            end
            stream << "'"
          end
        end
        stream << ">\n"
      when :content
        stream << "#{tag.attributes[:text]}\n"
        stream << "</#{node.parent.tag.type}>\n"
      else
        stream << "uh-oh.\n"
      end
    end

    stream
  end
end
