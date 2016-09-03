defmodule Essence.Document do
  @moduledoc """
  A document is a coherent text.
  """
  def from_file(filename) do
    content = File.read!(filename)
    content
  end

  def paragraphs(document) do
    pars = String.split(document, ~r/\n\n/u)
    pars
  end

end
