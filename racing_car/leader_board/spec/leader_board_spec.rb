require_relative '../leader_board'
describe LeaderBoard do
  let!(:driver_1) { Driver.new('Nico Rosberg', 'DE') }
  let!(:driver_2) { Driver.new("Lewis Hamilton", "UK") }
  let!(:driver_3) { Driver.new("Sebastian Vettel", "DE") }
  let!(:driver_4) { SelfDrivingCar.new("1.2", "ACME") }

  describe "#driver_points" do
    context "with no self driving cars" do
      it "returns all drivers and their points" do
        race_1 = Race.new("Australian Grand Prix", [driver_1, driver_2, driver_3])
        race_2 = Race.new("Malaysian Grand Prix", [driver_3, driver_2, driver_1])
        race_3 = Race.new("Chinese Grand Prix", [driver_2, driver_1, driver_3])

        expect(LeaderBoard.new([race_1, race_2, race_3]).driver_points).to eq(
          {
            "Lewis Hamilton" => 61,
            "Nico Rosberg" => 58,
            "Sebastian Vettel" => 55
          }
        )
      end
    end

    context "with self driving cars" do
      it "returns all drivers and their points" do
        race_1 = Race.new("Fictional Grand Prix", [driver_1, driver_2, driver_4])
        race_2 = Race.new("Fictional Grand Prix", [driver_4, driver_2, driver_1])
        driver_4.algorithm_version = "1.3"
        race_3 = Race.new("Fictional Grand Prix", [driver_2, driver_1, driver_4])

        expect(LeaderBoard.new([race_1, race_2, race_3]).driver_points).to eq(
          {
            "Lewis Hamilton" => 61,
            "Nico Rosberg" => 58,
            "Self Driving Car - ACME (1.3)" => 55
          }
        )
      end
    end
  end

  describe "#driver_rankings" do
    context "with no self driving cars" do
      it "returns driver names ordered by most points" do
        race_1 = Race.new("Australian Grand Prix", [driver_1, driver_2, driver_3])
        race_2 = Race.new("Malaysian Grand Prix", [driver_3, driver_2, driver_1])
        race_3 = Race.new("Chinese Grand Prix", [driver_2, driver_1, driver_3])

        expect(LeaderBoard.new([race_1, race_2, race_3]).driver_rankings).to eq(
          ["Lewis Hamilton", "Nico Rosberg", "Sebastian Vettel"]
        )
      end
    end

    context "with self driving cars" do
      it "returns driver names ordered by most points" do
        race_1 = Race.new("Fictional Grand Prix", [driver_1, driver_2, driver_4])
        race_2 = Race.new("Fictional Grand Prix", [driver_4, driver_2, driver_1])
        driver_4.algorithm_version = "1.3"
        race_3 = Race.new("Fictional Grand Prix", [driver_2, driver_1, driver_4])

        expect(LeaderBoard.new([race_1, race_2, race_3]).driver_rankings).to eq(
          ["Lewis Hamilton", "Nico Rosberg", "Self Driving Car - ACME (1.3)"]
        )
      end
    end
  end
end
