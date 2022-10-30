require_relative 'expense'

module Expenses
  class DinnerExpense < Expense
    DINNER_EXPENSE_LIMIT = 5000

    def meal?
      true
    end

    private

    def name
      "Dinner"
    end

    def over_limit?
      amount > DINNER_EXPENSE_LIMIT
    end
  end
end
