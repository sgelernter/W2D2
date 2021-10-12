require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries.has_key?(title)
    end

    def >(startup_2)
        self.funding > startup_2.funding
    end

    def hire(employee_name, title)
        if !salaries.has_key?(title)
            raise "That title is invalid" 
        else
            employees << Employee.new(employee_name, title)
        end
    end

    def size
        employees.length
    end

    def pay_employee(employee)
        pay = salaries[employee.title]
        if funding > pay
            employee.pay(pay)
            @funding -= pay
        else
            raise "Not enough cheddar bay biscuits, chief!"
        end
    end

    def payday
        employees.each { |emp| pay_employee(emp) }
    end

end
