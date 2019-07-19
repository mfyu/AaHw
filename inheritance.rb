class Employee
    def initialize(name, title, salary, boss)
        @name, @title, @salary, @boss = name, title, salary, boss
    end
    attr_reader :name, :title, :salary, :boss

    def bonus(multiplier)
        @bonus = @salary * multiplier
    end
end

class Manager < Employee
    def initialize(name, title, salary, boss)
        super
        @employees = []
    end
    attr_reader :employees

    def add_employee(employee)
        @employees<<employee
    end

    def bonus(multiplier)
        @bonus = subsalary * multiplier
    end

    def subsalary
        total = 0
        @employees.each do |e|
            if e.is_a?(Manager)
                total += e.salary + e.subsalary
            else
                total += e.salary
            end
        end
        total
    end

end

ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)  
david = Employee.new("David", "TA", 10000, darren)  
ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000

