class Rectangle
  attr_accessor :length, :width

  def initialize(length, width)
    @length = length
    @width = width
  end

  def calculate_area
    area = width * length
  end
end