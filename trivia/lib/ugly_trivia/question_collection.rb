require_relative 'question'

module UglyTrivia
  class QuestionCollection

    def initialize(categories:, size:)
      @questions = categories.each_with_object({}) do |category, questions|
        questions[category] = (0...size).map { |i| Question.new(category, i) }
      end
    end

    def next_question_for(location)
      category = category_for(location)
      @questions[category].shift
    end

    def category_for(location)
      @questions.keys[location % @questions.keys.size]
    end
  end
end
