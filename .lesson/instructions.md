# SOLID Principles - 1

## Object Oriented Design

Imagine a software Developer Alice who works on an app that allows users to order food 😋.

Alice works on a feature one day related to discounts on the app and then her code goes live in production the next day after testing.

__Everything is going Peaceful and Alice can Chill__
![chill](assets/chill.png)

__Three Months Later__
![This is fine](assets/this_is_fine.png)

## What Happened?

A lot has changed in last 3 months including your whole code base 😕.

### Yes Change Rains Upon Us

But there is no way out, it happens inevitably.

## Indicator of Bad Designs 🤢

Turns out there is something that hides beneath our code

* __Rigidity__ - Components are tightly coupled and as a result it is difficult to change the code.
* __Fragility__ -  Hidden dependencies which makes it difficult to change as it is likely to break if you do something to change it.
* __Immobility__ - Hard to reuse components and you have to again write code to the same things again and again.
* __Viscosity__ - Makes it hard to do the right things and makes way for bad practices.
* __Opacity__ - Difficulty in understanding the code, which results in unreadable code.

## Enters Object Oriented Design 

__Object oriented design is about managing dependencies.__

It is a set of coding techniques that arrange dependencies such that objects can tolerate change.

Object oriented applications are made up of parts that interact by sending messages to each others. Getting the right message to the correct target object requires that the sender of the message know things about the reciever. This knowledge creates dependencies between the two. Dependencies stand in the way if change.

## Solid Principles

### S - Single Responsibility Principle

Let's consider the code that a developer named Mallory wrote in at the first time.

He wrote a class `Employee` whith different methods like `full_name`, `task` and `compute_pay`.

```ruby
class Employee
  attr_accessor :first_name, :last_name, :working_level, :tax
 
  def initialize(first_name, last_name, working_level, tax)
    @first_name = first_name
    @last_name = last_name
    @working_level = working_level
    @tax = tax
  end
 
  def full_name
    "#{first_name} #{last_name}"
  end

  def task(date, employee_name)
    case date
    when "monday"
      "#{employee_name} implement birthday calculator"
    when "wednesday"
      "#{employee_name} add birthday entries"
    else 
      "#{employee_name} will fix issues"
    end
  end
  
  def compute_pay
    case working_level
      when 1
        3000000 - (3000000 * tax)
      when 2
        4000000 - (4000000 * tax)
      when 3
        5000000 - (5000000 * tax)
      else "unknown level"
    end
  end
end
```


__`full_name`__ - Get's the full name of the employee.

__`compute_pay`__ - Calculates the pay for the employee.

__`task`__ - Determines tasks for an employee on day by day basis.

#### Enters the Product Manager

Now the product manager comes to Mallory and asks him to make a few changes like -

1. Change name case(can be snake case, camel case etc.)
2. Add task for Friday
3. Modify pay calculation.

#### What shall Mallory do?

__Mallory decides to change `Employee` class becasue it has many responsibilities.__


### What is Single Responsibility Principle?
__Single Responsibility Principle__ - A class should have only one reason to change.

#### Let's Refactor our code

Starting with the method `task`. We will create a new Class named `TaskDeterminer` and put the code there.

```ruby
class TaskDeterminer
  def task(date, employee_name)
    case date
    when "monday"
      "#{employee_name} implement birthday calculator"
    when "wednesday"
      "#{employee_name} add birthday entries"
    else 
      "#{employee_name} will fix issues"
    end
  end
end
```

Now the `Employee` class will look something like this

```ruby
class Employee
  attr_accessor :first_name, :last_name, :working_level, :tax
 
  def initialize(first_name, last_name, working_level, tax)
    @first_name = first_name
    @last_name = last_name
    @working_level = working_level
    @tax = tax
  end
 
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def compute_pay
    case working_level
      when 1
        3000000 - (3000000 * tax)
      when 2
        4000000 - (4000000 * tax)
      when 3
        5000000 - (5000000 * tax)
      else "unknown level"
    end
  end
end
```

__What does `Employee` do?__
It can get full name and can calculate pay for a given employee.

__What does `TaskDeterminer` do?__
It can determine task by day for the employee.

__The responsibility for each class is lesser and clearer.__

__Question__ - Can we do refactor the `Employee` class more?

__Note -__ Just because you can, doesn't mean you should.


Always keep in mind that things that can change for one reason should be in the same class.


## O - Open/Closed Principle

Bob is working on an expense calculator program and wrote the following code.

```ruby
class ExpenseReport
  def print_monthly_report(format)
    case format
    when 'pdf'
      print_pdf_monthly_report
    when 'xls'
      print_xls_monthly_report
    end
  end

  def print_pdf_monthly_report
    puts "I'm printing expense report to PDF format"
  end

  def print_xls_monthly_report
    puts "I'm printing expense report to XLS format"
  end
end

```

#### Enters the Product Manager Again...
The product manager comes and asks Bob to add a feature to print the monthly expense report in JSON because customers want it 😬.

__What should we do in this case?__

Bob remembers the Open/Closed Principle which says - 

*Your code should be open for extension but closed for modification*

So he refactors his code like this - 

```ruby
class ExpenseReport
  def print_monthly_report(generator)
    generator.print_monthly_report
  end
end

class PdfGenerator
  def print_monthly_report
    puts "I'm printing expense report to PDF format"
  end
end

class XlsGenerator
  def print_monthly_report
    puts "I'm printing expense report to XLS format"
  end
end
```

Now he can print the reports in this way - 
```ruby
expense_report = ExpenseReport.new
pdf_generator = PdfGenerator.new
xls_generator = XlsGenerator.new

expense_report.print_monthly_report(pdf_generator)
expense_report.print_monthly_report(xls_generator)

```
In order to add a new JSON generator he just needs to add another class called `JSONGenerator`

```ruby
class JSONGenerator
  def print_monthly_report
    puts "I'm printing expense report to JSON format"
  end
end
```

Now he can print JSON reports very easily.
```ruby
expense_report = ExpenseReport.new
pdf_generator = PdfGenerator.new
xls_generator = XlsGenerator.new

# initialising json generator
json_generator = JSONGenerator.new

expense_report.print_monthly_report(pdf_generator)
expense_report.print_monthly_report(xls_generator)

# printing JSON report
expense_report.print_monthly_report(json_generator)

```
Now the product manager can ask for any kind of generator and bob would just have to write one more class and tada..🎉

### Hands On

We have a class `ShapeCalculator` to calculate area of a shape.

```ruby
class ShapeCalculator
  def initialize
  end

  def calculate_area(shape)
    area = 0

    if shape.name == "rectangle"
      area = shape.width * shape.length
    elsif shape.name == "triangle"
      area = shape.base * shape.height * 0.5
    end

    area
  end
end
```

```ruby
class Rectangle
  attr_accessor :name, :length, :width

  def initialize(name, length, width)
    @name = name
    @length = length
    @width = width
  end
end
```

```ruby
class Triangle
  attr_accessor :name, :base, :height

  def initialize(name, base, height)
    @name = name
    @base = base
    @height = height
  end
end
```

Refactor code so that it becomes open for extension and closed for modification. Then Support calculation of area of `Circle` as well.


---
## Homework

Use the principles you have learnt today in your project.