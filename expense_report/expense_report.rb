#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount
  def initialize(type, amount)
    @type = type
    @amount = amount
  end
end

class ExpenseReport
  def initialize(expenses)
    @expenses = expenses
  end

  def to_s
    mealExpenses = 0
    puts "Expenses: #{Time.now}"
    for expense in expenses
      if expense.type == :dinner || expense.type == :breakfast
        mealExpenses += expense.amount
      end
      expenseName = ""
      case expense.type
      when :breakfast
          expenseName = "Breakfast"
      when :dinner
          expenseName = "Dinner"
      when :car_rental
          expenseName = "Car Rental"
      end
      mealOverExpensesMarker = expense.type == :dinner && expense.amount > 5000 || expense.type == :breakfast && expense.amount > 1000 ? "X" : " "
      puts "#{expenseName}\t#{expense.amount}\t#{mealOverExpensesMarker}"
    end
    puts "Meal Expenses: #{mealExpenses}"
    puts "Total Expenses: #{total}"
  end

  private

  attr_reader :expenses

  def total
    expenses.sum(&:amount)
  end
end
