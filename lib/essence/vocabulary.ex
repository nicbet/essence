defmodule Essence.Vocabulary do
  @moduledoc """
  This module exports helpful methods around Vocabularies.
  """

  @doc """
  The `vocabulary` method computes the vocabulary of a text. The vocabulary
  is the unique set of dictionary words in that text.
  """
  def vocabulary(frequency_distribution) when is_map(frequency_distribution) do
    Map.keys(frequency_distribution)
  end
  def vocabulary(tokens) when is_list(tokens) do
    tokens
    |> freq_dist()
    |> vocabulary()
  end
  def vocabulary(text) when is_bitstring(text) do
    text
    |> Essence.Tokenizer.tokenize()
    |> vocabulary()
  end

  @doc """
  The `lexical_richness` method computes the lexical richness of a given
  text.
  """
  def lexical_richness(text) when is_bitstring(text) do
    tokens = Essence.Tokenizer.tokenize(text)
    text_length = Enum.count(tokens)
    token_set = vocabulary(tokens)
    # TODO Deal with text of length 0
    text_length / Enum.count(token_set)
  end

  @doc """
  The `freq_dist` method calculates the frequency distribution
  of tokens in the given text.
  """
  def freq_dist(text) when is_list(text) do
    text
    |> Enum.reduce(%{}, fn(token, acc) ->
        Map.update(acc, token, 1, &(&1 + 1))
      end)
  end
  def freq_dist(text) when is_bitstring(text) do
    freq_dist(Essence.Tokenizer.tokenize(text))
  end

end
