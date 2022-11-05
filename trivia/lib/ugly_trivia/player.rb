module UglyTrivia
  class Player
    attr_reader :name, :purse, :in_penalty_box

    def initialize(name)
      @name = name
      @purse = 0
      @in_penalty_box = false
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

  end
end
