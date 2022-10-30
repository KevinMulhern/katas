require_relative 'expense'

module Expenses
  class CarRentalExpense < Expense

    def name
      "Car Rental"
    end

    def over_limit?
      false
    end
  end
end
