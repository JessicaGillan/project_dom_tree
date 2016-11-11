require_relative 'node'
class Parser

  SELF_CLOSING = ["area",
                  "base",
                  "br",
                  "col",
                  "command",
                  "embed",
                  "hr",
                  "img",
                  "input",
                  "keygen",
                  "link",
                  "meta",
                  "param",
                  "source",
                  "track",
                  "wbr" ]
  OPENING = /<(\w+)/
  CLOSING = /<\/(\w+)/
  TYPE = /(\w+)/
  ATTRIBUTE_PAIR = /\s(.*?)\s*\=\s*['|"](.*?)['|"]/

  def parse_tag(html_snippet)
    tag_function = get_function(html_snippet)

    if tag_function == :content
      # Set attributes equal to string contents
      attribute_hash = { :text => html_snippet }
    else
      tag_type = get_tag_type(html_snippet)

      # Test type to reset function to :open or :open_close
      if tag_function == :open
        tag_function = SELF_CLOSING.include?(tag_type) ? :open_close : :open
      end

      attribute_hash = get_attribute_hash(html_snippet)
    end

    Tag.new(tag_function, tag_type ||= nil, attribute_hash ||= nil)
  end

  def get_function(snippet)
    if !!snippet.match(OPENING)
      :open
    elsif !!snippet.match(CLOSING)
      :close
    else
      :content
    end
  end

  def get_tag_type(html_snippet)
    html_snippet.match(TYPE)[0]
  end

  def get_attribute_hash(html_snippet)
    attributes = get_attributes_and_values(html_snippet)
    build_attribute_hash(attributes)
  end

  def get_attributes_and_values(html_snippet)
    html_snippet.scan(ATTRIBUTE_PAIR)
  end

  def build_attribute_hash(attributes)
    attribute_pairs = {}
    attributes.each do |pair|
      attribute_pairs[pair[0].to_sym] = pair[1].split
    end
    attribute_pairs
  end
end
