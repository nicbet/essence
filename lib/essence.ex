defmodule Essence do
  @moduledoc """
  Essence is a Natural Language Processing and Text Summarization
  Library for Elixir.
  """

  @doc """
  The `read_file` method reads a plain-text file from a given `filename`
  and returns a UTF-8 encoded bitstring representation of the text.
  """
  def read_file(filename) do
    text = File.read!(filename)
    text
  end

  def document_from_file(filename) do
    read_file(filename) |> Essence.Document.from_text()
  end

  @doc """
  The `stream_lines` method reads a plain-text file from a given `filename`
  and returns an UTF-8 encoded stream of lines. This allows us to perform
  efficient stream-processing of large text files.
  """
  def stream_lines(filename) do
    stream = File.stream!(filename, [], :line)
    stream
  end

  @doc """
  The `genesis` method is a convenience method for reading the supplemented
  plain-text file of the Book of Genesis, which is part of the Essence unit
  test suite.
  """
  def genesis() do
    read_file("test/genesis.txt")
  end

  @doc """
  The `trump` method is a convenience method for reading the supplemented
  plain-text file of the 2016 Donal Trump Nomination Acceptance Speech,
  which is part of the Essence unit test suite.
  """
  def trump() do
    read_file("test/trump-speech.txt")
  end

  @doc """
  The `clinton` method is a convenience method for reading the supplemented
  plain-text file of the 2016 Hillary Clinton Nomination Acceptance Speech,
  which is part of the Essence unit test suite.
  """
  def clinton() do
    read_file("test/clinton-speech.txt")
  end
end
