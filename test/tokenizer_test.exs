defmodule TokenizerTest do
  use ExUnit.Case
  doctest Essence.Tokenizer

  test "Tokenizes simple sentence" do
    assert ["This", "is", "a", "test"] == Essence.Tokenizer.tokenize("This is a test")
  end

  test "Tokenization works with multiple whitespace" do
    assert ["Happy", "couple"] == Essence.Tokenizer.tokenize("Happy    couple")
  end

  test "Tokenization recognizes punctuation" do
    assert ["Great", "deduction", ",", "Sherlock", "!"] == Essence.Tokenizer.tokenize("Great deduction, Sherlock!")
  end

  test "Tokenizes it's, what's, ... correctly" do
    assert ["it's", "cool"] == Essence.Tokenizer.tokenize("it's cool")
    assert ["What's", "up", "?"] == Essence.Tokenizer.tokenize("What's up?")
  end

  test "Tokenizes quotations correctly" do
    assert ["Lady", "Faraday", "said", ":", "'", "Oh", "dear","!", "'"] == Essence.Tokenizer.tokenize("Lady Faraday said: 'Oh dear!'")
  end
end
