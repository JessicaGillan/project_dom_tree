require_relative '../lib/node'
require_relative '../lib/HTML_tree'
require_relative '../lib/parser'
require_relative '../lib/DOM'
require_relative '../lib/DOM_loader'
require_relative '../lib/node_renderer'
require_relative '../lib/tree_searcher'

filepath = Dir.pwd + '/lib/test.html'
loader = DOMLoader.new

dom = loader.load(filepath)
tree = HTMLTree.new(dom)

tree.inspect

NodeRenderer.new(tree).render
