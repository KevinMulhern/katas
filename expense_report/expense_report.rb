#!/usr/bin/ruby

class DinnerExpense
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def name
    "Dinner"
  end

  def type
    :dinner
  end

  def meal?
    true
  end
end

class BreakfastExpense
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def name
    "Breakfast"
  end

  def type
    :breakfast
  end

  def meal?
    true
  end
end

class CarRentalExpense
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def name
    "Car Rental"
  end

  def type
    :car_rental
  end

  def meal?
    false
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
    expenses.select(&:meal?).sum(&:amount)
  end
end
