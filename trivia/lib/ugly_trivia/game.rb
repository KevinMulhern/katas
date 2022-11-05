require_relative 'player'

module UglyTrivia
  class Game
    def  initialize
      @players = []
      @places = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

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
      @places[@players.length] = 0
      @in_penalty_box[@players.length] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"

      true
    end

    def roll(roll)
      puts "#{current_player} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        handle_player_in_penalty_box(roll)
      else
        handle_player_not_in_penalty_box(roll)
      end
    end

    def was_correctly_answered
      if @in_penalty_box[@current_player]
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
      @in_penalty_box[@current_player] = true

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
      @places[@current_player] = @places[@current_player] + roll
      @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

      puts "#{current_player}'s new location is #{@places[@current_player]}"
      puts "The category is #{current_category}"
      ask_question
    end

    def handle_odd_roll(roll)
      @is_getting_out_of_penalty_box = true

      puts "#{current_player} is getting out of the penalty box"
      @places[@current_player] = @places[@current_player] + roll
      @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

      puts "#{current_player}'s new location is #{@places[@current_player]}"
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
      return 'Pop' if @places[@current_player] == 0
      return 'Pop' if @places[@current_player] == 4
      return 'Pop' if @places[@current_player] == 8
      return 'Science' if @places[@current_player] == 1
      return 'Science' if @places[@current_player] == 5
      return 'Science' if @places[@current_player] == 9
      return 'Sports' if @places[@current_player] == 2
      return 'Sports' if @places[@current_player] == 6
      return 'Sports' if @places[@current_player] == 10
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
