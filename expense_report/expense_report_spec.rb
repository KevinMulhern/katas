require_relative 'expense_report'

RSpec.describe ExpenseReport do

  describe "#print_report" do
    it "prints the report" do
      expenses = ExpenseCollection.new([
        Expenses::DinnerExpense.new(5000),
        Expenses::BreakfastExpense.new(1000),
        Expenses::CarRentalExpense.new(5000),
      ])

      expected_output = <<~EXPENSE_REPORT
        Expenses: #{Time.now}
        Dinner\t5000\t
        Breakfast\t1000\t
        Car Rental\t5000\t
        Meal Expenses: 6000
        Total Expenses: 11000
      EXPENSE_REPORT

      expect {
        described_class.new(expenses).to_s
      }.to output(
        expected_output
      ).to_stdout
    end

    context "when meal expenses are over their limits" do
      it "prints the report" do
        expenses = ExpenseCollection.new([
          Expenses::DinnerExpense.new(6000),
          Expenses::BreakfastExpense.new(7000),
          Expenses::CarRentalExpense.new(5000),
        ])

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Dinner\t6000\tX
          Breakfast\t7000\tX
          Car Rental\t5000\t
          Meal Expenses: 13000
          Total Expenses: 18000
        EXPENSE_REPORT

        expect {
          described_class.new(expenses).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end

    context "with lunch expense" do
      it "prints the report" do
        expenses = ExpenseCollection.new([
          Expenses::BreakfastExpense.new(1000),
          Expenses::LunchExpense.new(1000),
          Expenses::DinnerExpense.new(3000),
          Expenses::CarRentalExpense.new(5000)
        ])

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Breakfast\t1000\t
          Lunch\t1000\t
          Dinner\t3000\t
          Car Rental\t5000\t
          Meal Expenses: 5000
          Total Expenses: 10000
        EXPENSE_REPORT

        expect {
          described_class.new(expenses).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end

    context "with over limit lunch expense" do
      it "prints the report" do
        expenses = ExpenseCollection.new([
          Expenses::BreakfastExpense.new(1000),
          Expenses::LunchExpense.new(3000),
          Expenses::DinnerExpense.new(3000),
          Expenses::CarRentalExpense.new(5000)
        ])

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Breakfast\t1000\t
          Lunch\t3000\tX
          Dinner\t3000\t
          Car Rental\t5000\t
          Meal Expenses: 7000
          Total Expenses: 12000
        EXPENSE_REPORT

        expect {
          described_class.new(expenses).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end
  end
end
