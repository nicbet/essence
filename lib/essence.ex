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
    read_file("test/genesis.txt")
  end
end
