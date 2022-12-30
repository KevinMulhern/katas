class Dice

  def initialize(d1, d2, d3, d4, d5)
    @rolls = [d1, d2, d3, d4, d5]
  end

  def total
    @rolls.sum
  end

  def all_indentical?
    @rolls.uniq.size == 1
  end

  def sum_of(n)
    @rolls.count(n) * n
  end

  def highest_pair
    multiple_of(2).max
  end

  def sum_of_a_kind(n)
    multiple_of(n).sum
  end

  def small_straight?
    @rolls.sort == [1, 2, 3, 4, 5]
  end

  def large_straight?
    @rolls.sort == [2, 3, 4, 5, 6]
  end

  def full_house?
    @rolls.group_by(&:itself).all? {|_, v| v.size >= 2}
  end

  private

  def multiple_of(n)
    @rolls.group_by(&:itself).select { |_, v| v.size >= n }.keys
  end

end
