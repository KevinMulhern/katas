require 'spec_helper'
require_relative '../lib/ugly_trivia/questions_deck'

RSpec.describe UglyTrivia::QuestionsDeck do

  describe "#category_for" do
    it "returns a category for roll" do
      deck = described_class.new

      category = deck.category_for(0)

      expect(category).to eq("Pop")
    end
  end

  describe "#question_for" do
    it "returns a question for a roll" do
      deck = described_class.new(size: 2)

      question = deck.question_for(0)

      expect(question).to eq("Pop Question 0")
    end

    it "returns first question again after cycyling through all questions" do
      deck = described_class.new(size: 3)

      deck.question_for(1)
      deck.question_for(1)
      question = deck.question_for(1)

      expect(question).to eq("Science Question 2")

      question = deck.question_for(1)

      expect(question).to eq("Science Question 0")
    end
  end
end
