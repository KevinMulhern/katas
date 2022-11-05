require_relative 'player'

module UglyTrivia
  class Game
    def  initialize
      @players = []

      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      50.times do |i|
        @pop_questions.push "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push "Sports Question #{i}"
        @rock_questions.push "Rock Question #{i}"
      end
    end

    def add(player_name)
      @players.push Player.new(player_name)

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"

      true
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
          @current_player += 1
          @current_player = 0 if @current_player == @players.length

          winner
        else
          @current_player += 1
          @current_player = 0 if @current_player == @players.length
          true
        end
      else

        puts "Answer was corrent!!!!"
        current_player.add_coin
        puts "#{current_player} now has #{current_player.purse} Gold Coins."

        winner = did_player_win
        @current_player += 1
        @current_player = 0 if @current_player == @players.length

        return winner
      end
    end

    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{current_player} was sent to the penalty box"
      current_player.send_to_penalty_box

      @current_player += 1
      @current_player = 0 if @current_player == @players.length
      return true
    end

    private

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
      puts "The category is #{current_category}"
      ask_question
    end

    def handle_odd_roll(roll)
      @is_getting_out_of_penalty_box = true

      puts "#{current_player} is getting out of the penalty box"
      current_player.update_location(roll)

      puts "#{current_player}'s new location is #{current_player.location}"
      puts "The category is #{current_category}"
      ask_question
    end

    def handle_even_roll(roll)
      puts "#{current_player} is not getting out of the penalty box"
      @is_getting_out_of_penalty_box = false
    end

    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
    end

    def current_category
      return 'Pop' if current_player.location == 0
      return 'Pop' if current_player.location == 4
      return 'Pop' if current_player.location == 8
      return 'Science' if current_player.location == 1
      return 'Science' if current_player.location == 5
      return 'Science' if current_player.location == 9
      return 'Sports' if current_player.location == 2
      return 'Sports' if current_player.location == 6
      return 'Sports' if current_player.location == 10
      return 'Rock'
    end

    def did_player_win
      current_player.purse != 6
    end

    def current_player
      @players[@current_player]
    end
  end
end
