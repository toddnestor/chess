require_relative 'employee'

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss=nil)
    @employees = []
    super
  end

  def bonus(multiplier)
    employees_salaries * multiplier
  end

  def employees_salaries
    total_salaries = 0

    @employees.each do |employee|
      total_salaries += employee.salary
      total_salaries += employee.employees_salaries if employee.is_a?(Manager)
    end

    total_salaries
  end
end

if __FILE__ == $PROGRAM_NAME
  manager = Manager.new("larry", "dishwasher", 10)

  employees = []

  5.times do |i|
    employees[i] = Employee.new("Employee #{i+1}", "dish", 100, manager)
  end

  new_manager = Manager.new("Ned", "dish wiper", 5, manager)

  5.times do |i|
    employees[i] = Employee.new("Employee #{i+1}", "dish", 100, new_manager)
  end

  p manager.bonus(10)
end
