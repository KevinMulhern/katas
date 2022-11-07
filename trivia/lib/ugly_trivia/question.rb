module UglyTrivia
  class Question
    include Comparable
    attr_reader :category, :index

    def initialize(category, index)
      @category = category
      @index = index
    end

    def to_s
      "#{category} Question #{index}"
    end

    def <=>(other)
      [category, index] <=> [other.category, other.index]
    end
  end
end
