require_relative 'expense'

module Expenses
  class BreakfastExpense < Expense
    BREAKFAST_EXPENSE_LIMIT = 1000

    def meal?
      true
    end

    private

    def name
      "Breakfast"
    end

    def over_limit?
      amount > BREAKFAST_EXPENSE_LIMIT
    end
  end
end
