#!/usr/bin/ruby

class Expense
  attr_reader :type, :amount, :name
  def initialize(type, amount, name)
    @type = type
    @amount = amount
    @name = name
  end
end

class ExpenseReport
  def initialize(expenses)
    @expenses = expenses
  end

  def to_s
    puts "Expenses: #{Time.now}"

    expenses.each do |expense|
      mealOverExpensesMarker = expense.type == :dinner && expense.amount > 5000 || expense.type == :breakfast && expense.amount > 1000 ? "X" : " "
      puts "#{expense.name}\t#{expense.amount}\t#{mealOverExpensesMarker}"
    end
    puts "Meal Expenses: #{meal_expenses}"
    puts "Total Expenses: #{total}"
  end

  private

  attr_reader :expenses

  def total
    expenses.sum(&:amount)
  end

  def meal_expenses
    expenses.select { |expense| expense.type == :dinner || expense.type == :breakfast }.sum(&:amount)
  end
end
