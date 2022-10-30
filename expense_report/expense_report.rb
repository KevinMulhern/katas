#!/usr/bin/ruby

Dir.glob('expenses/*.rb') { |f| require_relative f }

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
