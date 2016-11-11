class DOMBuilder

  def build_from_tree(tree)
    tree.root.dfs do |node|
      tag = node.tag

      case tag.function
      when :open, :open_close
        print "<#{tag.type}"
        unless tag.attributes.empty?
          tag.attributes.each do |key, values|
            print " #{key}='"
            values.each do |value|
              print "#{value} "
            end
            print "'"
          end
        end
        puts ">"
      when :content
        puts "#{tag.attributes[:text]}"
        puts "</#{node.parent.tag.type}>"
      else
        puts "uh-oh."
      end
    end
  end
end
