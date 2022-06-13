module UglyTrivia
  class QuestionsDeck

    def initialize(size: 50)
      @pop_questions = create_questions(size, "Pop").cycle
      @science_questions = create_questions(size, "Science").cycle
      @sports_questions = create_questions(size, "Sports").cycle
      @rock_questions = create_questions(size, "Rock").cycle
    end

    def question_for(roll)
      category = category_for(roll)
      question_category[category].next
    end

    def category_for(roll)
      category_index = roll % question_category.keys.size
      question_category.keys[category_index]
    end

    private

    def create_questions(size, category)
      size.times.map { |index| "#{category} Question #{index}" }
    end

    def question_category
      {
        'Pop' => @pop_questions,
        'Science' => @science_questions,
        'Sports' => @sports_questions,
        'Rock' => @rock_questions
      }
    end

  end
end
