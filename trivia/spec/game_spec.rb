require 'spec_helper'
require_relative '../lib/ugly_trivia/game'

def test_game
  sequence = [2, 8, 2, 7, 4, 3, 3, 2, 1, 0, 3, 5, 1, 7, 2, 2, 5, 4, 4, 8, 3, 1, 2, 4, 2, 0, 5, 5, 1, 1, 4, 5, 1, 7, 5, 8]
  not_a_winner = false

  game = UglyTrivia::Game.new

  game.add 'Chet'
  game.add 'Pat'
  game.add 'Sue'

  begin
    game.roll(sequence.shift)

    if sequence.shift == 7
      not_a_winner = game.wrong_answer
    else
      not_a_winner = game.was_correctly_answered
    end

  end while not_a_winner
end

describe UglyTrivia::Game do
  it "returns expected output" do
    expected_output = <<~EOS
      Chet was added
      They are player number 1
      Pat was added
      They are player number 2
      Sue was added
      They are player number 3
      Chet is the current player
      They have rolled a 2
      Chet's new location is 2
      The category is Sports
      Sports Question 0
      Answer was corrent!!!!
      Chet now has 1 Gold Coins.
      Pat is the current player
      They have rolled a 2
      Pat's new location is 2
      The category is Sports
      Sports Question 1
      Question was incorrectly answered
      Pat was sent to the penalty box
      Sue is the current player
      They have rolled a 4
      Sue's new location is 4
      The category is Pop
      Pop Question 0
      Answer was corrent!!!!
      Sue now has 1 Gold Coins.
      Chet is the current player
      They have rolled a 3
      Chet's new location is 5
      The category is Science
      Science Question 0
      Answer was corrent!!!!
      Chet now has 2 Gold Coins.
      Pat is the current player
      They have rolled a 1
      Pat is getting out of the penalty box
      Pat's new location is 3
      The category is Rock
      Rock Question 0
      Answer was correct!!!!
      Pat now has 1 Gold Coins.
      Sue is the current player
      They have rolled a 3
      Sue's new location is 7
      The category is Rock
      Rock Question 1
      Answer was corrent!!!!
      Sue now has 2 Gold Coins.
      Chet is the current player
      They have rolled a 1
      Chet's new location is 6
      The category is Sports
      Sports Question 2
      Question was incorrectly answered
      Chet was sent to the penalty box
      Pat is the current player
      They have rolled a 2
      Pat is not getting out of the penalty box
      Sue is the current player
      They have rolled a 5
      Sue's new location is 0
      The category is Pop
      Pop Question 1
      Answer was corrent!!!!
      Sue now has 3 Gold Coins.
      Chet is the current player
      They have rolled a 4
      Chet is not getting out of the penalty box
      Pat is the current player
      They have rolled a 3
      Pat is getting out of the penalty box
      Pat's new location is 6
      The category is Sports
      Sports Question 3
      Answer was correct!!!!
      Pat now has 2 Gold Coins.
      Sue is the current player
      They have rolled a 2
      Sue's new location is 2
      The category is Sports
      Sports Question 4
      Answer was corrent!!!!
      Sue now has 4 Gold Coins.
      Chet is the current player
      They have rolled a 2
      Chet is not getting out of the penalty box
      Pat is the current player
      They have rolled a 5
      Pat is getting out of the penalty box
      Pat's new location is 11
      The category is Rock
      Rock Question 2
      Answer was correct!!!!
      Pat now has 3 Gold Coins.
      Sue is the current player
      They have rolled a 1
      Sue's new location is 3
      The category is Rock
      Rock Question 3
      Answer was corrent!!!!
      Sue now has 5 Gold Coins.
      Chet is the current player
      They have rolled a 4
      Chet is not getting out of the penalty box
      Pat is the current player
      They have rolled a 1
      Pat is getting out of the penalty box
      Pat's new location is 0
      The category is Pop
      Pop Question 2
      Question was incorrectly answered
      Pat was sent to the penalty box
      Sue is the current player
      They have rolled a 5
      Sue's new location is 8
      The category is Pop
      Pop Question 3
      Answer was corrent!!!!
      Sue now has 6 Gold Coins.
    EOS

    expect { test_game }.to output(a_string_including(expected_output)).to_stdout_from_any_process
  end
end
