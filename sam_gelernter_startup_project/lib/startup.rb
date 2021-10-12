require "employee"
require "byebug"

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

    def average_salary
        payroll = salaries.values.inject(0) do |total_pay, salary|
                job_title = salaries.key(salary)
                num_titles = employees
                                    .map { |emp| emp.title }
                                    .count(job_title)   
                total_pay += num_titles * salary
        end
        payroll / size
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(alt_startup)
        @funding += alt_startup.funding
        alt_startup.salaries.each {|job, salary| @salaries[job] = salary if !salaries.keys.include?(job) }
        @employees += alt_startup.employees
        alt_startup.close
    end

end
