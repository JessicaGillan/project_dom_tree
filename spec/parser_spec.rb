require 'parser'
require 'node'

describe Parser do
  let(:parser) { Parser.new }

  let(:header) { "<h1 class=\"emphasized\">"}
  let(:div) { "<div id = 'bim'>" }
  let(:p) { "<p class='foo bar' id='baz' name='fozzie'>" }
  let(:img) { "<img src='http://www.example.com' title='funny things'>" }
  let(:h1) { "<h1 id='dolphin bluewhale shark' class='animal amphibian' draggable='false'>" }
  let(:close_p) { "</p>" }
  let(:close_h) { "</h1>" }
  let(:close_li) { "</li>" }
  let(:content) { "Hello I has content!" }


  describe "#parse_tag" do
    it "returns a Tag struct" do
      expect(parser.parse_tag(header)).to be_a Tag
    end

    it "can parse header tags" do
      expect(parser.parse_tag(header).type).to eq("h1")
    end

    it "can parse p tags" do
      expect(parser.parse_tag(p).type).to eq("p")
    end

    it "can parse img tags" do
      expect(parser.parse_tag(img).type).to eq("img")
    end

    it "can parse div tags" do
      expect(parser.parse_tag(div).type).to eq("div")
    end

    it "marks opening tags" do
      expect(parser.parse_tag(div).function).to eq(:open)
    end

    it "marks self closing tags" do
      expect(parser.parse_tag(img).function).to eq(:open_close)
    end

    it "marks closing tags" do
      expect(parser.parse_tag(close_p).function).to eq(:close)
      expect(parser.parse_tag(close_h).function).to eq(:close)
      expect(parser.parse_tag(close_li).function).to eq(:close)
    end

    it "marks content" do
      expect(parser.parse_tag(content).function).to eq(:content)
    end

    it "can handle tags with attributes" do
      attrs = {:id=>["dolphin", "bluewhale", "shark"], :class=>["animal", "amphibian"], :draggable=>["false"]}
      expect(parser.parse_tag(h1).attributes).to eq(attrs)
    end
  end

end
