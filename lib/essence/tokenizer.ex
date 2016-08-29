defmodule Essence.Tokenizer do
  @moduledoc """
  The Tokenizer module exposes useful functions for transforming
  text into tokens and for dealing with tokens.
  """

  @doc """
  Splits a given String into tokens. A token is a sequence of characters to
  be treated as a group. The `tokenize` method will split on whitespace and
  punctuation, treating words and punctutation as tokens, and removing whitespace.
  """
  def tokenize(text) do
   text
   |> String.split(~r/\s+/u)
   |> Enum.reduce([], fn(x, acc) -> acc ++ split_punctuation(x) end)
  end

  @doc """
  Splits a given String into tokens on punctuation. Supports Unicode.
  """
  def split_punctuation(text) do
    if String.ends_with?(text, "'s") do
      [text]
    else
      #http://stackoverflow.com/questions/2206378/how-to-split-a-string-but-also-keep-the-delimiters
      text |> String.split(~r/((?<=\pP)|(?=\pP))/u, trim: true)
    end
  end

end
