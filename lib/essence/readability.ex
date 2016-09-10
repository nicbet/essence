defmodule Essence.Readability do
  @moduledoc """
  The Readbility module contains several methods for
  calculating the readability scores of a text.
  """
  alias Essence.{Document, Token}

  @doc """
  The `ari_score` method calculates the Automated Readability Index (ARI)
  of a given `Essence.Document`.

  ## Details
  The ARI uses two quantities, mu(w) and mu(s), where
  `mu(w)` is average number of letters per word in the given text and `mu(s)`
  is the average number of words per sentence in the given text.
  The ARI is then defined by the following formula:
  `ari = 4.71 * mu(w) + 0.5 * mu(s) - 21.43`

  Commonly, the ARI score is rounded up and translated by the following table:

 | ARI score | Readability Level | Reader Age |
 | --------- | ----------------- | ---------- |
 |  1        | Kindergarten      | 5-6        |
 |  2        | First Grade       | 6-7        |
 |  3        | Second Grade      | 7-8        |
 |  4        | Third Grade       | 8-9        |
 |  5        | Fourth Grade      | 9-10       |
 |  6        | Fifth Grade       | 10-11      |
 |  7        | Sixth Grade       | 11-12      |
 |  8        | Seventh Grade     | 12-13      |
 |  9        | Eighth Grade      | 13-14      |
 | 10        | Ninth Grade       | 14-15      |
 | 11        | Tenth Grade       | 15-16      |
 | 12        | Eleventh Grade    | 16-17      |
 | 13        | Twelth Grade      | 17-18      |
 | 14+       | College           | 18-22      |
  """
  def ari_score(doc = %Document{}) do
    mu_s = (doc |> Document.sentences |> Enum.map(&Enum.count/1) |> Enum.reduce(&+/2)) / (doc |> Document.sentences |> Enum.count)
    mu_w = Token.avg_word_length(doc |> Document.enumerate_tokens)
    ari = 4.71 * mu_w + 0.5 * mu_s - 21.43
    ari |> Float.ceil |> Kernel.trunc
  end

end
