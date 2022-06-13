require_relative "./player"
require_relative "./questions_deck"

module UglyTrivia
  class Game
    class NotEnoughPlayersError < StandardError;end

    MAX_PLAYER_LIMIT = 6
    MIN_PLAYER_LIMIT = 2

    attr_reader :current_player, :players

    def initialize
      @players = []
      @questions_deck = QuestionsDeck.new
    end

    def add(player_name)
      puts "No more players allowed" && return if @players.size == MAX_PLAYER_LIMIT

      @players.push(Player.new(name: player_name, id: players.size))
      puts "#{player_name} was added"
      puts "They are player number #{players.size}"
    end

    def roll(roll)
      raise NotEnoughPlayersError.new("Two players needed") if players.size < MIN_PLAYER_LIMIT

      puts "#{current_player} is the current player"
      puts "They have rolled a #{roll}"

      if current_player.in_penalty_box?
        remove_player_from_penalty_box(roll) && return if roll.odd?

        puts "#{current_player} is not getting out of the penalty box"
      else
        current_player.move_place(roll)
        ask_question
      end
    end

    def was_correctly_answered
      switch_player && return if current_player.in_penalty_box?

      puts "Answer was correct!!!!"
      current_player.add_coin!
      winner = did_player_win
      switch_player

      winner
    end

    def wrong_answer
  		puts 'Question was incorrectly answered'
  		puts "#{current_player} was sent to the penalty box"

      current_player.send_to_penalty_box!
      switch_player

      true
    end

    def current_player
      @current_player ||= players.first
    end

    private

    attr_reader :questions_deck

    def remove_player_from_penalty_box(roll)
      puts "#{current_player} is getting out of the penalty box"

      current_player.remove_from_penalty_box!
      current_player.move_place(roll)
      ask_question
    end

    def switch_player
      @current_player = players[(current_player.id + 1) % @players.size]
    end

    def ask_question
      puts "The category is #{questions_deck.category_for(current_player.place)}"
      puts questions_deck.question_for(current_player.place)
    end

    def did_player_win
      current_player.purse != 6
    end
  end
end
