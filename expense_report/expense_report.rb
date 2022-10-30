#!/usr/bin/ruby

Dir.glob('expenses/*.rb') { |f| require_relative f }
require_relative 'expense_collection'

class ExpenseReport
  def initialize(expenses)
    @expenses = expenses
  end

  def to_s
    puts "Expenses: #{Time.now}"

    expenses.each do |expense|
      puts expense.to_s
    end

    puts "Meal Expenses: #{expenses.meal_total}"
    puts "Total Expenses: #{expenses.total}"
  end

  private

  attr_reader :expenses
end
