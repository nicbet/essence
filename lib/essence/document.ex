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

  @doc """
  Retrieve the list of all words in the given `Essence.Document`, ignoring all tokens that are punctuation.
  """
  @spec words(document :: %Essence.Document{}) :: List.t
  def words(doc = %Essence.Document{}) do
    doc |> enumerate_tokens |> Enum.filter(&Essence.Token.is_word?/1)
  end

  @doc """
  Find all occurrences of `token` in the given `Essence.Document`. Returns a
  list of [token: index] tuples.
  """
  @spec find_token(doc :: %Essence.Document{}, token :: String.t) :: List.t
  def find_token(doc = %Essence.Document{}, token) do
    doc |> Essence.Document.enumerate_tokens |> Enum.with_index |> Enum.filter( fn({tok, _idx}) -> String.upcase(tok) == String.upcase(token) end )
  end

  @doc """
  For each occurrence of `token` in the given `Essence.Document`, `doc`,
  returns a list containing the token as well as `n` (default=5) tokens to the left and
  right of the occurrence.
  """
  @spec context_of(doc :: %Essence.Document{}, token :: String.t, n :: number) :: List.t
  def context_of(doc = %Essence.Document{}, token, n \\ 5) do
    indices = doc |> find_token(token)
    tokens = doc |> enumerate_tokens
    indices |> Enum.map( fn({tok, idx}) -> context_left(tokens, idx-1, n) ++ [tok] ++ context_right(tokens, idx+1, n) end)
  end

  @doc """
  Pretty prints all occurrences of `token` in the given `Essence.Document`,
  `doc`. Prints `n` (default=20) characters of context.
  """
  @spec concordance(doc :: %Essence.Document{}, token :: String.t, n :: number) :: none
  def concordance(doc = %Essence.Document{}, token, n \\ 20) do
    doc |> context_of(token, round(n / 5)+2) |> Enum.each(&center(&1, n))
  end

  defp context_left(token_list, idx, len) do
    token_list |> Enum.slice( (max(0, idx-len))..(idx) )
  end

  defp context_right(token_list, idx, len) do
    token_list |> Enum.slice( (idx)..(min(Enum.count(token_list), idx+len)) )
  end

  defp center(token_list, len) do
    mid = round(Enum.count(token_list) / 2) -1
    l = token_list |> Enum.slice(0..mid-1) |> Enum.join(" ")
    lx = l |> String.slice(-(min(len, String.length(l)))..-1) |> String.pad_leading(len, " ")

    mx = Enum.at(token_list, mid)

    r = token_list |> Enum.slice(mid+1..Enum.count(token_list)) |> Enum.join(" ")
    rx = r |> String.slice(0..min(len, String.length(r))) |> String.pad_trailing(len, " ")

    IO.puts("#{lx} #{mx} #{rx}")
  end

  @doc """
  Returns a list of all the 1-contexts (1 token to the left, 1 token to the right) of the
  given `token` in the given `document`, excluding the token itself.
  """
  @spec one_contexts_of(doc :: %Essence.Document{}, token :: String.t) :: List.t
  def one_contexts_of(doc = %Essence.Document{}, token) do
    indices = doc |> find_token(token)
    tokens = doc |> enumerate_tokens
    indices |> Enum.map( fn({_tok, idx}) -> context_left(tokens, idx-1, 0) ++ context_right(tokens, idx+1, 0) end)
  end
end
