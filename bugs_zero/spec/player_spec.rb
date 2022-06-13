require 'spec_helper'
require_relative '../lib/ugly_trivia/player'

RSpec.describe UglyTrivia::Player do

  describe "#in_penalty_box?" do
    it "returns true when the player is in the penalty box" do
      player = described_class.new(name: "Bob", id: 0)

      player.send_to_penalty_box!

      expect(player.in_penalty_box?).to eq(true)
    end

    it "returns false when the player is not in the penalty box" do
      player = described_class.new(name: "Bob", id: 0)

      expect(player.in_penalty_box?).to eq(false)
    end
  end

  describe "#send_to_penalty_box!" do
    it "sends player to the penalty box" do
      player = described_class.new(name: "Bob", id: 0)

      expect { player.send_to_penalty_box!}.to change { player.in_penalty_box? }.from(false).to(true)
    end
  end

  describe "#remove_from_penalty_box!" do

    it "removes player from the penalty box" do
      player = described_class.new(name: "Bob", id: 0)

      player.send_to_penalty_box!

      expect { player.remove_from_penalty_box! }.to change { player.in_penalty_box? }.from(true).to(false)
    end
  end

  describe "#add_coin!" do
    it "adds a coin to the players purse" do
      player = described_class.new(name: "Bob", id: 0)

      expect { player.add_coin! }.to change { player.purse }.from(0).to(1)
    end
  end

  describe "#move_place" do

    it "moves the player to the new place" do
      player = described_class.new(name: "Bob", id: 0)

      expect { player.move_place(5) }.to change { player.place }.from(0).to(5)
    end

    context "when new place is above 11" do
      it "moves the player to start" do
        player = described_class.new(name: "Bob", id: 0)
        player.move_place(6)

        expect { player.move_place(6) }.to change { player.place }.from(6).to(0)
      end

    end

  end
end
