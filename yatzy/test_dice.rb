require_relative 'dice'
require 'test/unit'

class DiceTest < Test::Unit::TestCase
  def test_total
    assert 15 == Dice.new(2,3,4,5,1).total
    assert 16 == Dice.new(3,3,4,5,1).total
  end

  def test_all_indentical
    assert true == Dice.new(4,4,4,4,4).all_indentical?
    assert true == Dice.new(6,6,6,6,6).all_indentical?
    assert false == Dice.new(6,6,6,6,3).all_indentical?
  end

  def test_sum_of
    assert 1 == Dice.new(1,2,3,4,5).sum_of(1)
    assert 4 == Dice.new(2,1,2,4,5).sum_of(2)
    assert 0 == Dice.new(6,2,2,4,5).sum_of(1)
    assert 15 == Dice.new(3,3,3,3,3).sum_of(3)
  end

  def test_highest_pair
    assert 3 == Dice.new(3,4,3,5,6).highest_pair
    assert 5 == Dice.new(5,3,3,3,5).highest_pair
    assert 6 == Dice.new(5,3,6,6,5).highest_pair
  end

  def test_sum_of_a_kind
    assert 7 == Dice.new(3,4,3,4,6).sum_of_a_kind(2)
    assert 3 == Dice.new(5,3,3,3,5).sum_of_a_kind(3)
    assert 11 == Dice.new(5,3,6,6,5).sum_of_a_kind(2)
  end

  def test_small_straight
    assert true == Dice.new(1,2,3,4,5).small_straight?
    assert false == Dice.new(2,3,4,5,6).small_straight?
  end

  def test_large_straight
    assert true == Dice.new(2,3,4,5,6).large_straight?
    assert false == Dice.new(1,2,3,4,5).large_straight?
  end

  def test_full_house
    assert true == Dice.new(2,2,4,4,4).full_house?
    assert false == Dice.new(2,2,4,4,5).full_house?
  end
end
