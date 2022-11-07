require 'spec_helper'
require_relative '../lib/ugly_trivia/question_collection'
require_relative '../lib/ugly_trivia/question'

describe UglyTrivia::QuestionCollection do

  describe "#next_question_for" do
    it "returns the next question for a given location" do
      questions = UglyTrivia::QuestionCollection.new(categories: ['Pop', 'Science', 'Sports', 'Rock'], size: 50)
      expect(questions.next_question_for(0)).to eq(UglyTrivia::Question.new('Pop', 0))
    end
  end

  describe "#category_for" do
    it "returns the category for a given location" do
      categories = ['Pop', 'Science', 'Sports', 'Rock']
      size = 50
      question_collection = UglyTrivia::QuestionCollection.new(categories: categories, size: size)

      expect(question_collection.category_for(0)).to eq('Pop')
      expect(question_collection.category_for(1)).to eq('Science')
      expect(question_collection.category_for(2)).to eq('Sports')
      expect(question_collection.category_for(3)).to eq('Rock')
      expect(question_collection.category_for(4)).to eq('Pop')
      expect(question_collection.category_for(5)).to eq('Science')
    end
  end
end
