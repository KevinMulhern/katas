class Critter
  attr_reader :name, :aside, :punctuation

  def initialize(name, aside, punctuation)
    @name = name
    @aside = aside
    @punctuation = punctuation
  end
end

class Song

  DATA = [
    ["horse", "...She's dead, of course!", "..."],
    ["cow", "I don't know how she swallowed a cow!", ";"],
    ["dog", "What a hog, to swallow a dog!", ";"],
    ["cat", "Fancy that to swallow a cat!", ";"],
    ["bird", "How absurd to swallow a bird.", ";"],
    ["spider", "That wriggled and wiggled and tickled inside her.", ";"],
    ["fly", "I don't know why she swallowed a fly - perhaps she'll die!", "."]
  ]

  attr_reader :critters

  def initialize(data=DATA)
    @critters = data.map { |row| Critter.new(*row) }
  end

  def lyrics
    (1..critters.size).map do |i|
      case i
      when 1, critters.size
        ShortVerse.new(critters.last(i))
      else
        LongVerse.new(critters.last(i))
      end
    end.join("\n")
  end

  class ShortVerse

    attr_reader :critters, :critter

    def initialize(critters)
      @critters = critters
      @critter = critters.first
    end

    def to_s
      incident + recap
    end

    private

    def incident
      "There was an old lady who swallowed a %s%s\n%s\n" % [
        critter.name,
        critter.punctuation,
        critter.aside
      ]
    end

    def recap
      ""
    end

  end

  class LongVerse < ShortVerse

    private

    def recap
      "%s;\n" % chain +
      "%s\n" % critters.last.aside
    end

    def chain
      critters.each_cons(2).map do |pair|
        motivation(*pair)
      end.join(",\n")
    end

    def motivation(predator, prey)
      "She swallowed the %s to catch the %s" % [predator.name, prey.name]
    end
  end
end
