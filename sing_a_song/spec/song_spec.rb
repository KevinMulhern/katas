require_relative '../song'

describe Song do

  context "with the original verses" do
    it "returns the default version of the song" do
      expected =  <<~HEREDOC
      There was an old lady who swallowed a fly.
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a spider;
      That wriggled and wiggled and tickled inside her.
      She swallowed the spider to catch the fly;
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a bird;
      How absurd to swallow a bird.
      She swallowed the bird to catch the spider,
      She swallowed the spider to catch the fly;
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a cat;
      Fancy that to swallow a cat!
      She swallowed the cat to catch the bird,
      She swallowed the bird to catch the spider,
      She swallowed the spider to catch the fly;
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a dog;
      What a hog, to swallow a dog!
      She swallowed the dog to catch the cat,
      She swallowed the cat to catch the bird,
      She swallowed the bird to catch the spider,
      She swallowed the spider to catch the fly;
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a cow;
      I don't know how she swallowed a cow!
      She swallowed the cow to catch the dog,
      She swallowed the dog to catch the cat,
      She swallowed the cat to catch the bird,
      She swallowed the bird to catch the spider,
      She swallowed the spider to catch the fly;
      I don't know why she swallowed a fly - perhaps she'll die!

      There was an old lady who swallowed a horse...
      ...She's dead, of course!
      HEREDOC

      expect(Song.new.lyrics).to eq(expected)
    end
  end

  context "with a custom verse" do
    it "returns the custom version of the song" do
      expected =  <<~HEREDOC
      There was an old lady who swallowed a rabbit.
      I don't know why she swallowed a rabbit - perhaps she'll die!

      There was an old lady who swallowed a sheep;
      What a hog, to swallow a sheep!
      She swallowed the sheep to catch the rabbit;
      I don't know why she swallowed a rabbit - perhaps she'll die!

      There was an old lady who swallowed a shark;
      I don't know how she swallowed a shark!
      She swallowed the shark to catch the sheep,
      She swallowed the sheep to catch the rabbit;
      I don't know why she swallowed a rabbit - perhaps she'll die!

      There was an old lady who swallowed a man...
      ...She's fucked, of course!
      HEREDOC

      data = [
        ["man", "...She's fucked, of course!", "..."],
        ["shark", "I don't know how she swallowed a shark!", ";"],
        ["sheep", "What a hog, to swallow a sheep!", ";"],
        ["rabbit", "I don't know why she swallowed a rabbit - perhaps she'll die!", "."]
      ]

      expect(Song.new(data).lyrics).to eq(expected)
    end
  end
end
