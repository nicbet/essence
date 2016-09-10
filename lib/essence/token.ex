defmodule Essence.Token do
  @moduledoc """
  This module contains helpful functions around Tokens
  """

  @doc """
  Calculates the average word length over the given list of `tokens`.
  """
  def avg_word_length(tokens) when is_list(tokens) do
    (tokens |> Enum.map(&token_length/1) |> Enum.reduce(&+/2) ) / Enum.count(tokens)
  end

  @doc """
  Calculates the length of a `token` as the number of graphemes in that token.
  """
  def token_length(token) do
    String.length(token)
  end

  @doc """
  Count the number of syllabels in a `token`.
  """
  def count_syllabels(token) do
    token |> String.replace(~r/[aeiouAEIOUyY]+/, " ") |> String.replace(~r/[^ ]/,"") |> String.length
  end

  @doc """
  Determines whether a given `token` is a polysyllabic or not.
  """
  def is_polysyllabic?(token) do
    count_syllabels(token) > 1
  end

end
