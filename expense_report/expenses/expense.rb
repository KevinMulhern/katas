module Expenses
  class Expense
    attr_reader :amount

    def initialize(amount)
      @amount = amount
    end

    def to_s
      "#{name}\t#{amount}\t#{'X' if over_limit?}"
    end

    def meal?
      false
    end

    private

    def name
      raise NotImplementedError
    end

    def over_limit?
      raise NotImplementedError
    end

    def limit
      raise NotImplementedError
    end
  end
end
