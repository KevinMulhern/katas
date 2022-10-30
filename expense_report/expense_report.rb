#!/usr/bin/ruby

class DinnerExpense
  LIMIT = 5000
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def to_s
    "#{name}\t#{amount}\t#{over_limit? ? 'X' : ' '}"
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

  def over_limit?
    amount > LIMIT
  end
end

class BreakfastExpense
  LIMIT = 1000
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def to_s
    "#{name}\t#{amount}\t#{over_limit? ? 'X' : ' '}"
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

  def over_limit?
    amount > LIMIT
  end
end

class CarRentalExpense
  attr_reader :amount

  def initialize(amount)
    @amount = amount
  end

  def to_s
    "#{name}\t#{amount}\t "
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

  def over_limit?
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
      puts expense.to_s
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
