defmodule VocabularyTest do
  use ExUnit.Case
  doctest Essence.Vocabulary

  test "Vocabularizes simple sentence" do
    fd = %{"a" => 2, "day" => 2, "," => 1, "what" => 1}
    assert Essence.Vocabulary.freq_dist("a day, what a day") == fd
  end

  test "Computes lexical richness correctly" do
    text_sample = """
      The birch begins to crack its outer sheath 
      Of baby green and show the white beneath
    """
    
    d = Essence.Document.from_text(text_sample)
    assert Essence.Vocabulary.lexical_richness(d) == (16 / 15)
  end

end
