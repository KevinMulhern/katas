module Expenses
  class DinnerExpense
    LIMIT = 5000
    attr_reader :amount

    def initialize(amount)
      @amount = amount
    end

    def to_s
      "#{name}\t#{amount}\t#{'X' if over_limit?}"
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
end
