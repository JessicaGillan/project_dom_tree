require_relative '../lib/node'
require_relative '../lib/HTML_tree'
require_relative '../lib/parser'
require_relative '../lib/DOM'
require_relative '../lib/DOM_loader'
require_relative '../lib/node_renderer'
require_relative '../lib/tree_searcher'
require_relative '../lib/DOM_builder'

loader = DOMLoader.new
builder = DOMBuilder.new

filepath = Dir.pwd + '/lib/test.html'

dom_units = loader.load(filepath)
tree = HTMLTree.new(dom_units)

NodeRenderer.new(tree).render

string = builder.build_from_tree(tree)
File.open('rebuilt.html', 'w') { |f| f.write(string) }
