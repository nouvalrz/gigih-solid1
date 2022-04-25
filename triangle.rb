class Triangle
  attr_accessor  :base, :height

  def initialize(base, height)
    @base = base
    @height = height
  end

  def calculate_area
    area = base * height * 0.5
  end
end