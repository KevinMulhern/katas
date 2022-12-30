require_relative 'yatzy'
require_relative 'dice'
require 'test/unit'

class YatzyTest < Test::Unit::TestCase
  def test_chance_scores_sum_of_all_dice
    assert 15 == Yatzy.new(Dice.new(2,3,4,5,1)).chance
    assert 16 == Yatzy.new(Dice.new(3,3,4,5,1)).chance
  end

  def test_yatzy_scores_50
    assert 50 == Yatzy.new(Dice.new(4,4,4,4,4)).yatzy
    assert 50 == Yatzy.new(Dice.new(6,6,6,6,6)).yatzy
    assert 0 == Yatzy.new(Dice.new(6,6,6,6,3)).yatzy
  end

  def test_ones
    assert 1 == Yatzy.new(Dice.new(1,2,3,4,5)).ones
    assert 2 == Yatzy.new(Dice.new(1,2,1,4,5)).ones
    assert 0 == Yatzy.new(Dice.new(6,2,2,4,5)).ones
    assert 4 == Yatzy.new(Dice.new(1,2,1,1,1)).ones
  end

  def test_twos
    assert 4 == Yatzy.new(Dice.new(1,2,3,2,6)).twos
    assert 10 == Yatzy.new(Dice.new(2,2,2,2,2)).twos
  end

  def test_threes
    assert 6 == Yatzy.new(Dice.new(1,2,3,2,3)).threes
    assert 12 == Yatzy.new(Dice.new(2,3,3,3,3)).threes
  end

  def test_fours
    assert 12 == Yatzy.new(Dice.new(4,4,4,5,5)).fours
    assert 8 == Yatzy.new(Dice.new(4,4,5,5,5)).fours
    assert 4 == Yatzy.new(Dice.new(4,5,5,5,5)).fours
  end

  def test_fives
    assert 10 == Yatzy.new(Dice.new(4,4,4,5,5)).fives
    assert 15 == Yatzy.new(Dice.new(4,4,5,5,5)).fives
    assert 20 == Yatzy.new(Dice.new(4,5,5,5,5)).fives
  end

  def test_sixes
    assert 0 == Yatzy.new(Dice.new(4,4,4,5,5)).sixes
    assert 6 == Yatzy.new(Dice.new(4,4,6,5,5)).sixes
    assert 18 == Yatzy.new(Dice.new(6,5,6,6,5)).sixes
  end

  def test_one_pair
    assert 6 == Yatzy.new(Dice.new(3,4,3,5,6)).score_pair
    assert 10 == Yatzy.new(Dice.new(5,3,3,3,5)).score_pair
    assert 12 == Yatzy.new(Dice.new(5,3,6,6,5)).score_pair
  end

  def test_two_pair
    assert 16 == Yatzy.new(Dice.new(3,3,5,4,5)).two_pair
    assert 16 == Yatzy.new(Dice.new(3,3,5,5,5)).two_pair
  end

  def test_three_of_a_kind
    assert 9 == Yatzy.new(Dice.new(3,3,3,4,5)).three_of_a_kind
    assert 15 == Yatzy.new(Dice.new(5,3,5,4,5)).three_of_a_kind
    assert 9 == Yatzy.new(Dice.new(3,3,3,3,5)).three_of_a_kind
    assert 9 == Yatzy.new(Dice.new(3,3,3,3,3)).three_of_a_kind
  end

  def test_four_of_a_kind
    assert 12 == Yatzy.new(Dice.new(3,3,3,3,5)).four_of_a_kind
    assert 20 == Yatzy.new(Dice.new(5,5,5,4,5)).four_of_a_kind
    assert 12 == Yatzy.new(Dice.new(3,3,3,3,3)).four_of_a_kind
  end

  def test_small_straight
    assert 15 == Yatzy.new(Dice.new(1,2,3,4,5)).small_straight
    assert 15 == Yatzy.new(Dice.new(2,3,4,5,1)).small_straight
    assert 0 == Yatzy.new(Dice.new(1,2,2,4,5)).small_straight
  end

  def test_large_straight
    assert 20 == Yatzy.new(Dice.new(6,2,3,4,5)).large_straight
    assert 20 == Yatzy.new(Dice.new(2,3,4,5,6)).large_straight
    assert 0 == Yatzy.new(Dice.new(1,2,2,4,5)).large_straight
  end

  def test_full_house
    assert 18 == Yatzy.new(Dice.new(6,2,2,2,6)).full_house
    assert 0 == Yatzy.new(Dice.new(2,3,4,5,6)).full_house
  end
end
