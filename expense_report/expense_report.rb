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

  def meal?
    true
  end

  private

  def name
    "Dinner"
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

  def meal?
    true
  end

  private

  def name
    "Breakfast"
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

  def meal?
    false
  end

  private

  def name
    "Car Rental"
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

    puts "Meal Expenses: #{expenses.select(&:meal?).sum(&:amount)}"
    puts "Total Expenses: #{expenses.sum(&:amount)}"
  end

  private

  attr_reader :expenses
end
