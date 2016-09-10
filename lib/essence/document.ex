defmodule Essence.Document do
  defstruct type: "", uri: "", text: "", nested_tokens: [], meta: %{}

  @moduledoc """
  This module defines the struct type `Essence.Document`, as well as a
  variety of convenience methods for access the document's text, paragraphs,
  sentences and tokens.
  """

  @doc """
  Read the `text` represented by a `String` and create an `Essence.Document`.
  """
  @spec from_text(text :: String.t) :: %Essence.Document{}
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

  @doc """
  Retrieve the tokenized paragraphs from the given `Essence.Document`.
  """
  @spec paragraphs(document :: %Essence.Document{}) :: List.t
  def paragraphs(%Essence.Document{nested_tokens: tokens}) do
    tokens
  end

  @doc """
  Retrieve a the `n`-th tokenized paragraph from the given `Essence.Document`
  """
  @spec paragraph(document :: %Essence.Document{}, n :: integer) :: List.t 
  def paragraph(%Essence.Document{nested_tokens: tokens}, n) do
    tokens |> Enum.at(n)
  end

  @doc """
  Retrieve the tokenized sentences from the given `Essence.Document`.
  """
  @spec sentences(document :: %Essence.Document{}) :: List.t
  def sentences(%Essence.Document{nested_tokens: tokens}) do
    tokens |> List.foldl([], fn(x, acc) -> acc ++ x end)
  end

  @doc """
  Retrieve the `n`-th tokenized sentence from the given `Essence.Document`
  """
  @spec sentence(document :: %Essence.Document{}, n :: integer) :: List.t
  def sentence(doc = %Essence.Document{}, n) do
    doc |> sentences |> Enum.at(n)
  end

  @doc """
  Retrieve the list of all tokens contained in the given `Essence.Document`
  """
  @spec enumerate_tokens(document :: %Essence.Document{}) :: List.t
  def enumerate_tokens(%Essence.Document{nested_tokens: tokens}) do
    tokens |> List.flatten()
  end
end
