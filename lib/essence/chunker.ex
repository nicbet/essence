defmodule Essence.Chunker do
  @moduledoc """
  This module contains helpful methods to chunk text into paragraphs and sentences.
  """

  @doc """
  Chunks a given `text` into paragraphs. A paragraph is any text, separated by two or more newline characters.
  """
  @spec paragraphs(String.t) :: List.t
  def paragraphs(text) do
    text |> String.split(~r/\n{2,}/u)
  end

  @doc """
  Chunks the given `text` into sentences.
  """
  @spec sentences(String.t) :: List.t
  def sentences(text) do
    # PCRE taken from https://en.wikipedia.org/wiki/Sentence_boundary_disambiguation
    text |> String.split(~r/((?<=[a-z0-9][.?!])|(?<=[a-z0-9][.?!]\"))(\s|\r\n)(?=\"?[A-Z])/u)
  end

end
