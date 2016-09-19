class Employee
  attr_accessor :boss
  attr_reader :name, :title, :salary

  def initialize(name, title, salary, boss=nil)
    @name = name
    @title = title
    @salary = salary
    self.boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def boss=(boss)
    boss.employees << self unless boss.nil?
    @boss = boss
  end
end
