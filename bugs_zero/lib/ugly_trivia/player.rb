module UglyTrivia
  class Player
    attr_reader :name, :id, :purse, :place

    def initialize(name:, id:)
      @name = name
      @id = id
      @in_penalty_box = false
      @purse = 0
      @place = 0
    end

    def in_penalty_box?
      @in_penalty_box
    end

    def send_to_penalty_box!
      @in_penalty_box = true
    end

    def remove_from_penalty_box!
      @in_penalty_box = false
    end

    def add_coin!
      @purse += 1
      puts "#{name} now has #{purse} Gold Coins."
    end

    def move_place(new_place)
      @place += new_place
      @place -= 12 if place > 11

      puts "#{name}'s new location is #{place}"
    end

    def to_s
      @name
    end
  end
end
