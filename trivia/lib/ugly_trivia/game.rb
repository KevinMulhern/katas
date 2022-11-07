require_relative 'player'
require_relative 'player_collection'
require_relative 'question_collection'

module UglyTrivia
  class Game
    def  initialize
      @players = PlayerCollection.new
      @questions = QuestionCollection.new(categories: ['Pop', 'Science', 'Sports', 'Rock'], size: 50)
    end

    def add(player_name)
      @players.add(player_name)
    end

    def roll(roll)
      puts "#{current_player} is the current player"
      puts "They have rolled a #{roll}"

      if current_player.in_penalty_box
        remove_from_penalty_box(roll) if roll.odd?

        puts "#{current_player} is not getting out of the penalty box" if roll.even?
      else
        current_player.update_location(roll)

        ask_question
      end
    end

    def was_correctly_answered
      if current_player.in_penalty_box
        switch_players
      else
        puts "Answer was corrent!!!!"
        current_player.add_coin

        winner = did_player_win
        switch_players

        winner
      end
    end

    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{current_player} was sent to the penalty box"
      current_player.send_to_penalty_box

      switch_players
    end

    private

    attr_reader :players

    def remove_from_penalty_box(roll)
      puts "#{current_player} is getting out of the penalty box"
      current_player.remove_from_penalty_box!

      current_player.update_location(roll)

      ask_question
    end

    def ask_question
      puts "The category is #{current_category}"
      puts @questions.next_question_for(current_player.location)
    end

    def current_category
      @questions.category_for(current_player.location)
    end

    def did_player_win
      current_player.purse != 6
    end

    def current_player
      @players.current_player
    end

    def switch_players
      @players.switch_players
    end
  end
end
