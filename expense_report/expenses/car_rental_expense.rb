
module Expenses
  class CarRentalExpense
    attr_reader :amount

    def initialize(amount)
      @amount = amount
    end

    def to_s
      "#{name}\t#{amount}\t"
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
end
