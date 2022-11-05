module UglyTrivia
  class Player
    attr_reader :name, :purse

    def initialize(name)
      @name = name
      @purse = 0
    end

    def to_s
      name
    end

    def add_coin
      @purse += 1
    end

  end
end
