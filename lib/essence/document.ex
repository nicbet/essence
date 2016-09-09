defmodule Essence.Document do
  defstruct type: "", uri: "", text: "", nested_tokens: [], meta: %{}

  @moduledoc """
  A document is a coherent text.
  """

  def from_text(text) when is_bitstring(text) do
    paragraphs = Essence.Chunker.paragraphs(text)
    sentences = paragraphs |> Enum.map( fn(x) -> Essence.Chunker.sentences(x) end )
    tokens = sentences |> Enum.map(fn(x) -> x |> Enum.map(fn(y) -> Essence.Tokenizer.tokenize(y) end) end)
    %Essence.Document{
      type: :plain_text,
      uri: "",
      text: text,
      nested_tokens: tokens
    }
  end

  def paragraphs(%Essence.Document{nested_tokens: tokens}) do
    tokens
  end

  def paragraph(%Essence.Document{nested_tokens: tokens}, num) do
    tokens |> Enum.at(num)
  end

  def sentences(%Essence.Document{nested_tokens: tokens}) do
    tokens |> List.foldl([], fn(x, acc) -> acc ++ x end)
  end

  def sentence(doc = %Essence.Document{}, num) do
    doc |> sentences |> Enum.at(num)
  end

  def enumerate_tokens(%Essence.Document{nested_tokens: tokens}) do
    tokens |> List.flatten()
  end
end
