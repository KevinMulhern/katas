class Yatzy
  def self.chance(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].sum
  end

  def self.yatzy(dice)
    if dice.uniq.size == 1
      return 50
    else
      return 0
    end
  end

  def self.ones(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].count(1)
  end

  def self.twos(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].count(2) * 2
  end

  def self.threes(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].count(3) * 3
  end

  def initialize(d1, d2, d3, d4, d5)
    @dice = [d1, d2, d3, d4, d5]
  end

  def fours
    @dice.count(4) * 4
  end

  def fives()
    @dice.count(5) * 5
  end

  def sixes
    @dice.count(6) * 6
  end

  def self.score_pair(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].group_by(&:itself).select do |_, v|
      v.size >= 2
    end.keys.max * 2
  end

  def self.two_pair(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].group_by(&:itself).select { |_, v| v.size >= 2}.keys.sum * 2
  end

  def self.three_of_a_kind(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].group_by(&:itself).select { |_, v| v.size >= 3}.keys.sum * 3
  end

  def self.four_of_a_kind(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].group_by(&:itself).select { |_, v| v.size >= 4 }.keys.sum * 4
  end

  def self.small_straight(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].sort == [1, 2, 3, 4, 5] ? 15 : 0
  end

  def self.large_straight(d1, d2, d3, d4, d5)
    [d1, d2, d3, d4, d5].sort == [2, 3, 4, 5, 6] ? 20 : 0
  end

  def self.full_house(d1, d2, d3, d4, d5)
    dice = [d1, d2, d3, d4, d5]

    if dice.group_by(&:itself).all? {|_, v| v.size >= 2}
      dice.sum
    else
      0
    end
  end
end
