require_relative 'expense_report'

RSpec.describe ExpenseReport do

  describe "#print_report" do

    it "prints the report" do
      expense_one = DinnerExpense.new(5000)
      expense_two = BreakfastExpense.new(1000)
      expense_three = CarRentalExpense.new(5000)

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

    context "when meal expenses are over their limits" do
      it "prints the report" do
        expense_one = DinnerExpense.new(6000)
        expense_two = BreakfastExpense.new(7000)
        expense_three = CarRentalExpense.new(5000)

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

    context "with lunch expense" do
      it "prints the report" do
        breakfast = BreakfastExpense.new(1000)
        lunch = LunchExpense.new(1000)
        dinner = DinnerExpense.new(3000)
        car_rental = CarRentalExpense.new(5000)

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Breakfast\t1000\t\s
          Lunch\t1000\t\s
          Dinner\t3000\t\s
          Car Rental\t5000\t\s
          Meal Expenses: 5000
          Total Expenses: 10000
        EXPENSE_REPORT

        expect {
          described_class.new([breakfast, lunch, dinner, car_rental]).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end

    context "with over limit lunch expense" do
      it "prints the report" do
        breakfast = BreakfastExpense.new(1000)
        lunch = LunchExpense.new(3000)
        dinner = DinnerExpense.new(3000)
        car_rental = CarRentalExpense.new(5000)

        expected_output = <<~EXPENSE_REPORT
          Expenses: #{Time.now}
          Breakfast\t1000\t\s
          Lunch\t3000\tX
          Dinner\t3000\t\s
          Car Rental\t5000\t\s
          Meal Expenses: 7000
          Total Expenses: 12000
        EXPENSE_REPORT

        expect {
          described_class.new([breakfast, lunch, dinner, car_rental]).to_s
        }.to output(
          expected_output
        ).to_stdout
      end
    end
  end
end
