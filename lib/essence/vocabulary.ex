defmodule Essence.Vocabulary do
  @moduledoc """
  This module exports helpful methods around Vocabularies.
  """

  @doc """
  Returns the vocabulary of a given text or token list. The vocabulary is
  the unique set of dictionary words. Each token is normalized, and the
  token frequency in the given text is calculated.
  """
  def vocabulary(text) when is_list(text) do
    text
    |> Enum.reduce(%{}, fn(token, acc) ->
        Map.update(acc, token, 1, &(&1 + 1))
      end)
  end
  def vocabulary(text) when is_bitstring(text) do
    vocabulary(Essence.Tokenizer.tokenize(text))
  end
end
