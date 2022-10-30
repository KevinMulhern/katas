require_relative 'expense'

module Expenses
  class LunchExpense < Expense
    LUNCH_EXPENSE_LIMIT = 2000

    def meal?
      true
    end

    private

    def name
      "Lunch"
    end

    def over_limit?
      amount > LUNCH_EXPENSE_LIMIT
    end
  end
end
