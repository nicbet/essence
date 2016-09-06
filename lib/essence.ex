defmodule Essence do
  def read_file(filename) do
    text = File.read!(filename)
    text
  end

  def stream_lines(filename) do
    stream = File.stream!(filename, [], :line)
    stream
  end

  def genesis() do
    text = read_file("test/genesis.txt")
    pars = Essence.Document.paragraphs(text)
    tok_p1 = Enum.at(pars, 1) |> Essence.Tokenizer.tokenize
    tok_p1
  end
end
