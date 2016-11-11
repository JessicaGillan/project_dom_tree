# HTML Document Object Model
class DOM
  include Enumerable

  def initialize(data)
    @html_units = format_data(data)
  end

  def each
    @html_units.each do |unit|
      yield(unit)
    end
  end

  def [](index)
    @html_units[index]
  end

  def delete_at(index)
    @html_units.delete_at(index)
  end

  private

  def format_data(data)
    # Join array in to string w/o newlines
    d = data.join.gsub("\n","")

    # Separate in to array of HTML chunks
    d.gsub!("<","@<")
    d.gsub!(">",">@")
    d = d.split("@")
    d.map! do |line|
      line.strip
    end

    # Return HTML array w/o empty lines
    d.delete_if { |line| line.empty? }
  end
end
