require_relative '../lib/node'
require_relative '../lib/HTML_tree'
require_relative '../lib/parser'
require_relative '../lib/DOM'
require_relative '../lib/DOM_loader'
require_relative '../lib/node_renderer'
require_relative '../lib/tree_searcher'
require_relative '../lib/DOM_builder'

filepath = Dir.pwd + '/lib/test.html'
loader = DOMLoader.new

dom_units = loader.load(filepath)
tree = HTMLTree.new(dom_units)

DOMBuilder.new.build_from_tree(tree)

# NodeRenderer.new(tree).render
