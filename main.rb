require_relative 'shape_calculator'
require_relative 'rectangle'
require_relative 'triangle'
require_relative 'circle'

shape_calculator = ShapeCalculator.new
rectangle = Rectangle.new(20, 30)
triangle = Triangle.new(10, 20)
circle = Circle.new(20)

shape_calculator.calculate_area(rectangle)
shape_calculator.calculate_area(triangle)
shape_calculator.calculate_area(circle)
