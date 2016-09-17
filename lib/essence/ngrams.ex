defmodule Essence.Ngrams do
 @moduledoc """
 This module offers various utility functions for generating
 bi-grams, tri-grams, and n-grams for given textual elements.
 """

  @doc """
  Calculate a list of two consecutive token pairs (bi-grams) from the
  given `token_list` or `Essence.Document`.
  """
  def bigrams(token_list) when is_list(token_list) do
    token_list |> Enum.chunk(2,1)
  end
  def bigrams(doc = %Essence.Document{}) do
    doc |> Essence.Document.enumerate_tokens |> bigrams
  end

  @doc """
  Calculate a list of three consecutive token triples (tri-grams) from
  the given `token_list` or `Essence.Docuemnt`.
  """
  def trigrams(token_list) when is_list(token_list) do
    token_list |> Enum.chunk(3,1)
  end
  def trigrams(doc = %Essence.Document{}) do
    doc |> Essence.Document.enumerate_tokens |> trigrams
  end

  @doc """
  Calculate a list of n consecutive token sequences (n-grams) from
  the given `token_list` or `Essence.Docuemnt`.
  """
  def ngrams(token_list, n) when is_list(token_list) do
    token_list |> Enum.chunk(n, 1)
  end
  def ngrams(doc = %Essence.Document{}, n) do
    doc |> Essence.Document.enumerate_tokens |> ngrams(n)
  end

end
