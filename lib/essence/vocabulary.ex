defmodule Essence.Vocabulary do
  @moduledoc """
  This module exports helpful methods around Vocabularies.
  """

  @doc """
  The `vocabulary` method computes the vocabulary of a given
  `Essence.Document`. The vocabulary is the unique set of dictionary words in
  that text.
  """
  @spec vocabulary(Essence.Document.t) :: List.t
  def vocabulary(d = %Essence.Document{}) do
    vocabulary(Essence.Document.enumerate_tokens d)
  end
  @spec vocabulary( Map.t ) :: List.t
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
  def lexical_richness(d = %Essence.Document{}) do
    n_tokens = d |> Essence.Document.enumerate_tokens |> Enum.count
    vocab_size = d |> vocabulary |> Enum.count
    n_tokens / vocab_size
  end
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
  def freq_dist(d = %Essence.Document{}) do
    freq_dist Essence.Document.enumerate_tokens d
  end
  def freq_dist(tokens) when is_list(tokens) do
    tokens
    |> Enum.reduce(%{}, fn(token, acc) ->
        Map.update(acc, token, 1, &(&1 + 1))
      end)
  end
  def freq_dist(text) when is_bitstring(text) do
    freq_dist(Essence.Tokenizer.tokenize(text))
  end

end
