defmodule Essence.Chunker do

  @doc """
  Chunks a given `text` into paragraphs. A paragraph is any text, separated by two or more newline characters.
  """
  def paragraphs(text) do
    text |> String.split(~r/\n{2,}/u)
  end

  @doc """
  Chunks the given `text` into sentences.
  """
  def sentences(text) do
    # PCRE taken from https://en.wikipedia.org/wiki/Sentence_boundary_disambiguation
    text |> String.split(~r/((?<=[a-z0-9][.?!])|(?<=[a-z0-9][.?!]\"))(\s|\r\n)(?=\"?[A-Z])/u)
  end

end
