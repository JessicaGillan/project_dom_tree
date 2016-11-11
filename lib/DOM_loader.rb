class DOMLoader

  def load(file_path)
    raise ArgumentError unless file_path.is_a? String
    raise ArgumentError unless File.exist?(file_path)
    data =  File.readlines(file_path)
    DOM.new(data)
  end
end
