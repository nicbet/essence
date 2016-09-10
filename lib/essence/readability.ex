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

  Commonly, the ARI score is rounded up and translated by the following table:

  ARI score | Readability Level | Reader Age
  ------------------------------------------
  1         | Kindergarten      | 5-6
  2         | First Grade       | 6-7
  3         | Second Grade      | 7-8
  4         | Third Grade       | 8-9
  5         | Fourth Grade      | 9-10
  6         | Fifth Grade       | 10-11
  7         | Sixth Grade       | 11-12
  8         | Seventh Grade     | 12-13
  9         | Eighth Grade      | 13-14
  10        | Ninth Grade       | 14-15
  11        | Tenth Grade       | 15-16
  12        | Eleventh Grade    | 16-17
  13        | Twelth Grade      | 17-18
  14+       | College           | 18-22
  """
  def ari_score(doc = %Essence.Document{}) do
    mu_s = (doc |> Essence.Document.sentences |> Enum.map(&Enum.count/1) |> Enum.reduce(&+/2)) / (doc |> Essence.Document.sentences |> Enum.count)
    mu_w = avg_word_length(doc |> Essence.Document.enumerate_tokens)
    ari = 4.71 * mu_w + 0.5 * mu_s - 21.43
    ari |> Float.ceil |> Kernel.trunc
  end

  @doc """
  Calculates the average length of tokens in graphemes over a list of tokens.
  """
  defp avg_word_length(tokens) when is_list(tokens) do
    (tokens |> Enum.map(&token_length/1) |> Enum.reduce(&+/2) ) / Enum.count(tokens)
  end

  @doc """
  Calculates the length of a `token` as the number of graphemes in that token.
  """
  defp token_length(token) do
    String.length(token)
  end

end
