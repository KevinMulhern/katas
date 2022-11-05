module UglyTrivia
  class PlayerCollection
    include Enumerable

    def initialize
      @players = []
    end

    def add(name)
      @players.push(Player.new(name))

      puts "#{name} was added"
      puts "They are player number #{players.size}"
    end

    def current_player
      @current_player ||= players.first
    end

    def switch_players
      @current_player = players[players.index(current_player) + 1]
    end

    def each(&block)
      players.each(&block)
    end

    private

    attr_reader :players

  end
end
