defmodule VocabularyTest do
  use ExUnit.Case
  doctest Essence.Vocabulary

  test "Vocabularizes simple sentence" do
    voc = %{"a" => 2, "day" => 2, "," => 1, "what" => 1}
    assert Essence.Vocabulary.vocabulary("a day, what a day") == voc
  end

end
