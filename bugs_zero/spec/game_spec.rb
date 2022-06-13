require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

RSpec.describe UglyTrivia::Game do

  describe "#add" do
    it "will add a player" do
      game = described_class.new

      game.add("Bob")

      expect(game.players.size).to eq(1)
    end

    it "will not add more than 6 players" do
      game = described_class.new

      game.add("Bob")
      game.add("Dave")
      game.add("Eve")
      game.add("Frank")
      game.add("George")
      game.add("Harry")
      game.add("Ivan")
      game.add("John")

      expect(game.players.size).to eq(6)
    end
  end

  describe "#roll" do
    subject(:game) { described_class.new }

    context "when there are 2 players or more" do

      before do
        game.add("Bob")
        game.add("John")
      end

      it "will ask the user a Pop question when the roll is a 4" do
        expect { game.roll(4) }.to output(/Pop Question 0/).to_stdout
      end

      it "will ask the user a Science question when the roll is a 1" do
        expect { game.roll(1) }.to output(/Science Question 0/).to_stdout
      end

      it "will ask the user a sports question when the roll is a 2" do
        expect { game.roll(2) }.to output(/Sports Question 0/).to_stdout
      end

      it "will ask the user a rock question when the roll is a 11" do
        expect { game.roll(11) }.to output(/Rock Question 0/).to_stdout
      end

      it "will increment the question number" do
        game.roll(1)

        expect { game.roll(4) }.to output(/Science Question 1/).to_stdout
      end

      context "when the player is in the penalty box and they roll an odd number" do
        it "will move the player out of the penalty box" do
          game.roll(1)
          game.wrong_answer
          game.roll(2)
          game.was_correctly_answered

          expect { game.roll(3) }.to output(/Bob is getting out of the penalty box/).to_stdout
        end

        context "when the player is in the penalty box and they roll an even number" do
          it "will not move the player out of the penalty box" do
            game.roll(1)
            game.wrong_answer
            game.roll(2)
            game.was_correctly_answered

            expect { game.roll(4) }.to output(/Bob is not getting out of the penalty box/).to_stdout
          end
        end
      end
    end

    context "when there are less than 2 players" do
      it "will raise an not enough players error" do
        expect { game.roll(3) }.to raise_error(UglyTrivia::Game::NotEnoughPlayersError)
      end
    end
  end

  describe "#was_correctly_answered" do
    subject(:game) { described_class.new }

    before do
      game.add("Bob")
      game.add("John")
    end

    context "when the player is in the penalty box" do

      it "will not give the user a gold coin" do
        game.roll(1)
        game.wrong_answer
        game.roll(2)
        game.was_correctly_answered
        game.roll(4)

        expect { game.was_correctly_answered }.not_to output(/Bob now has 1 Gold Coins./).to_stdout
      end

      it "will switch the player" do
        game.current_player.send_to_penalty_box!
        game.was_correctly_answered

        expect(game.current_player.name).to eq("John")
      end

      it "return true" do
        game.current_player.send_to_penalty_box!
        game.was_correctly_answered

        expect(game.was_correctly_answered).to be(true)
      end
    end

    context "when the player is not in the penalty box" do

      it "will give the user a gold coin" do
        expect { game.was_correctly_answered }.to output(/Bob now has 1 Gold Coins./).to_stdout
      end

      it "will switch the player" do
        game.was_correctly_answered

        expect(game.current_player.name).to eq("John")
      end

      it "return true if the has less than 6 gold coins" do
        expect(game.was_correctly_answered).to be(true)
      end

      it "return false if the player has 6 gold coins" do
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered
        game.was_correctly_answered

        expect(game.was_correctly_answered).to be(false)
      end
    end
  end

  describe "#wrong_answer" do
    let(:game) { described_class.new }

    before do
      game.add("Bob")
      game.add("John")
    end

    it "sends the player to the penalty box" do
      game.roll(1)

      expect { game.wrong_answer }.to output(/Bob was sent to the penalty box/).to_stdout
    end

    it "switches players" do
      game.was_correctly_answered

      expect(game.current_player.name).to eq("John")
    end

    it "returns true" do
      expect(game.wrong_answer).to be(true)
    end
  end
end
