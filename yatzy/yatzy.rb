class Yatzy
  def initialize(dice)
    @dice = dice
  end

  def chance
    dice.total
  end

  def yatzy
    dice.all_indentical? ? 50 : 0
  end

  def ones
    dice.sum_of(1)
  end

  def twos
    dice.sum_of(2)
  end

  def threes
    dice.sum_of(3)
  end

  def fours
    dice.sum_of(4)
  end

  def fives
    dice.sum_of(5)
  end

  def sixes
    dice.sum_of(6)
  end

  def score_pair
    dice.highest_pair * 2
  end

  def two_pair
    dice.sum_of_a_kind(2) * 2
  end

  def three_of_a_kind
    dice.sum_of_a_kind(3) * 3
  end

  def four_of_a_kind
    dice.sum_of_a_kind(4) * 4
  end

  def small_straight
    dice.small_straight? ? 15 : 0
  end

  def large_straight
    dice.large_straight? ? 20 : 0
  end

  def full_house
    dice.full_house? ? dice.total : 0
  end

  private

  attr_reader :dice
end
