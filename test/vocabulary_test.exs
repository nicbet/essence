defmodule VocabularyTest do
  use ExUnit.Case
  doctest Essence.Vocabulary

  test "Vocabularizes simple sentence" do
    fd = %{"a" => 2, "day" => 2, "," => 1, "what" => 1}
    assert Essence.Vocabulary.freq_dist("a day, what a day") == fd
  end

end
