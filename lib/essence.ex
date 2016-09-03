defmodule Essence do
  def read_file(filename) do
    text = File.read!(filename)
    text
  end
end
