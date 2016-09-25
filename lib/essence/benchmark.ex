defmodule Essence.Benchmark do
  import ExProf.Macro
  @moduledoc """
  This module contains a collection of methods that assist in benchmarking and
  performance optimizing the Essence package.
  """

  @doc """
  Reading a plain text file from the given `filename` path and tokenizing the
  text. Alternative A.
  """
  @spec from_plaintext_file_a(filename :: String.t) :: %Essence.Document{}
  def from_plaintext_file_a(filename) do
    profile do
      content = File.read!(filename)
      tokens = Essence.Tokenizer.tokenize(content)
      %Essence.Document{
        type: :plain_text,
        uri: filename,
        text: content,
        nested_tokens: tokens
      }
    end
  end

  @doc """
  Reading a plain text file from the given `filename` path and tokenizing the
  text. Alternative B.
  """
  @spec from_plaintext_file_b(filename :: String.t) :: %Essence.Document{}
  def from_plaintext_file_b(filename) do
    profile do
      stream = Essence.stream_lines(filename)
      tokens = Essence.Tokenizer.tokenize_s(stream)
      %Essence.Document{
        type: :plain_text,
        uri: filename,
        text: "",
        nested_tokens: tokens
      }
    end
  end

end
