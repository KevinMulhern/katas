module UglyTrivia
  class Player
    attr_reader :name, :purse, :in_penalty_box, :location

    def initialize(name)
      @name = name
      @purse = 0
      @in_penalty_box = false
      @location = 0
    end

    def to_s
      name
    end

    def add_coin
      @purse += 1
    end

    def send_to_penalty_box
      @in_penalty_box = true
    end

    def remove_from_penalty_box!
      @in_penalty_box = false
    end

    def update_location(roll)
      @location = (@location + roll) % 12
      puts "#{name}'s new location is #{location}"
    end

  end
end
