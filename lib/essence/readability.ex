defmodule Essence.Readability do
  @moduledoc """
  The Readbility module contains several methods for
  calculating the readability scores of a text.
  """

  @doc """
  The ari_score method calculates the Automated Readability Index (ARI)
  of a given text. The ARI uses two quantities, mu(w) and mu(s), where
  mu(w) is average number of letters per word in the given text and mu(s)
  is the average number of words per sentence in the given text.
  The ARI is then defined by the following formula:
  `ari = 4.71 * mu(w) + 0.5 * mu(s) - 21.43`
  """
  def ari_score(text) when is_bitstring(text) do

  end
  def ari_score(tokens) when is_list(tokens) do
    avg_word_len = ( tokens |> Enum.map(&token_length/1) |> Enum.reduce(&+/2) ) / Enum.count(tokens)
    avg_word_len
  end

  @doc """
  Calculates the length of a `token` as the number of graphemes in that token.
  """
  def token_length(token) do
    String.length(token)
  end
end
