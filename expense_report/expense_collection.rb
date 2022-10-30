class ExpenseCollection
  include Enumerable

  def initialize(expenses)
    @expenses = expenses
  end

  def total
    @expenses.sum(&:amount)
  end

  def meal_total
    @expenses.select(&:meal?).sum(&:amount)
  end

  def each(&block)
    @expenses.each(&block)
  end
end
