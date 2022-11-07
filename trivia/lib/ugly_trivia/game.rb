require_relative 'player'
require_relative 'player_collection'
require_relative 'question_collection'

module UglyTrivia
  class Game
    def  initialize
      @players = PlayerCollection.new
      @questions = QuestionCollection.new(categories: ['Pop', 'Science', 'Sports', 'Rock'], size: 50)

      @is_getting_out_of_penalty_box = false
    end

    def add(player_name)
      @players.add(player_name)
    end

    def roll(roll)
      puts "#{current_player} is the current player"
      puts "They have rolled a #{roll}"

      if current_player.in_penalty_box
        handle_player_in_penalty_box(roll)
      else
        handle_player_not_in_penalty_box(roll)
      end
    end

    def was_correctly_answered
      if current_player.in_penalty_box
        if @is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          current_player.add_coin
          puts "#{current_player} now has #{current_player.purse} Gold Coins."

          winner = did_player_win()
          switch_players

          winner
        else
          switch_players
          true
        end
      else

        puts "Answer was corrent!!!!"
        current_player.add_coin
        puts "#{current_player} now has #{current_player.purse} Gold Coins."

        winner = did_player_win
        switch_players

        return winner
      end
    end

    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{current_player} was sent to the penalty box"
      current_player.send_to_penalty_box

      switch_players
      return true
    end

    private

    attr_reader :players

    def handle_player_in_penalty_box(roll)
      if roll.odd?
        handle_odd_roll(roll)
      else
        handle_even_roll(roll)
      end
    end

    def handle_player_not_in_penalty_box(roll)
      current_player.update_location(roll)
      puts "#{current_player}'s new location is #{current_player.location}"

      ask_question
    end

    def handle_odd_roll(roll)
      @is_getting_out_of_penalty_box = true

      puts "#{current_player} is getting out of the penalty box"

      current_player.update_location(roll)
      puts "#{current_player}'s new location is #{current_player.location}"

      ask_question
    end

    def handle_even_roll(roll)
      puts "#{current_player} is not getting out of the penalty box"
      @is_getting_out_of_penalty_box = false
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
