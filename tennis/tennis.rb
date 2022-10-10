class Score
  include Comparable

  DEFAULT_CALLS = {
    0 => "Love",
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
  }

  def self.for(value)
    new(value, DEFAULT_CALLS.fetch(value, "Deuce"))
  end

  attr_reader :value, :call

  def initialize(value, call)
    @value = value
    @call = call
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    call
  end

  def three_or_above?
    value >= 3
  end
end

class Player

  attr_reader :name, :score

  def initialize(name)
    @name = name
    @score = Score.for(0)
  end

  def points
    @score.value
  end

  def add_point
    @score = Score.for(@score.value + 1)
  end
end

class GameScore

  def self.for(*args)
    new(*args)
  end

  def initialize(players)
    @first_player = players.first
    @second_player = players.last
    @players = players
  end

  def result
    return draw_result if draw?
    return "Advantage #{winning_player.name}" if advantage?
    return "Win for #{winning_player.name}" if winner?
    "#{first_player.score}-#{@second_player.score}"
  end

  private

  attr_reader :first_player, :second_player, :players

  def draw?
    first_player.score == second_player.score
  end

  def draw_result
    return "Deuce" if first_player.score.three_or_above?
    "#{first_player.score}-All"
  end

  def advantage?
    any_player_has_more_than_3_points? && points_difference == 1
  end

  def winner?
    any_player_has_more_than_3_points? && points_difference > 1
  end

  def winning_player
    players.max_by(&:points)
  end

  def points_difference
    (first_player.points - second_player.points).abs
  end

  def any_player_has_more_than_3_points?
    players.any? { |player| player.points >= 4 }
  end
end



class TennisGame1

  def initialize(player1Name, player2Name)
    @player_one = Player.new(player1Name)
    @player_two = Player.new(player2Name)
  end

  def won_point(playerName)
    current_player = players.find { |player| player.name == playerName }

    current_player.add_point
  end

  def score
    GameScore.for(players).result
  end

  private

  def players
    [@player_one, @player_two]
  end
end

class TennisGame2

  def initialize(player1Name, player2Name)
    @player_one = Player.new(player1Name)
    @player_two = Player.new(player2Name)
  end

  def won_point(playerName)
    current_player = players.find { |player| player.name == playerName }

    current_player.add_point
  end

  def score
    GameScore.for(players).result
  end

  private

  def players
    [@player_one, @player_two]
  end
end

class TennisGame3

  def initialize(player1Name, player2Name)
    @player_one = Player.new(player1Name)
    @player_two = Player.new(player2Name)
  end

  def won_point(playerName)
    current_player = players.find { |player| player.name == playerName }

    current_player.add_point
  end

  def score
    GameScore.for(players).result
  end

  private

  def players
    [@player_one, @player_two]
  end
end
