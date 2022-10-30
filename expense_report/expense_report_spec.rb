require_relative 'expense_report'

RSpec.describe ExpenseReport do

  describe "#print_report" do

    it "prints the report" do
      expense_one = Expense.new(:dinner, 5000)
      expense_two = Expense.new(:breakfast, 1000)
      expense_three = Expense.new(:car_rental, 5000)

      expected_output = <<~EXPENSE_REPORT
        Expenses: #{Time.now}
        Dinner\t5000\t\s
        Breakfast\t1000\t\s
        Car Rental\t5000\t\s
        Meal Expenses: 6000
        Total Expenses: 11000
      EXPENSE_REPORT

      expect {
        described_class.new([expense_one, expense_two, expense_three]).to_s
      }.to output(
        expected_output
      ).to_stdout
    end

    context "when meal expense is over 5000" do
      it "prints the report" do
        expense_one = Expense.new(:dinner, 6000)
        expense_two = Expense.new(:breakfast, 7000)
        expense_three = Expense.new(:car_rental, 5000)

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Dinner\t6000\tX
          Breakfast\t7000\tX
          Car Rental\t5000\t\s
          Meal Expenses: 13000
          Total Expenses: 18000
        EXPENSE_REPORT

        expect {
          described_class.new([expense_one, expense_two, expense_three]).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end
  end
end
