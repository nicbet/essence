[![Build Status](https://semaphoreci.com/api/v1/nicbet/essence/branches/master/shields_badge.svg)](https://semaphoreci.com/nicbet/essence)
![Project Stage](https://img.shields.io/badge/stage-pre--alpha-red.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/essence.svg?maxAge=2592000)](https://hex.pm/packages/essence)

# Essence

Essence is a Natural Language Processing (NLP) and Text Summarization library for Elixir. The work is currently in very early stages.

## ToDo

- [x] Tokenization (Basic, done)
- [x] Sentence Detection and Chunking (Basic, done)
- [x] Vocabulary (Basic, done)
- [x] Documents (Draft, done)
- [ ] **Readability** (ARI done, SMOG done, FC todo, GF done, DC done, CL todo)
- [x] Reading Time estimates (how long would it take somebody to read the given text, useful for blog posts / articles)
- [x] Speaking Time estimates (how long would it take somebody to present the given content, useful for speeches, presentations)
- [ ] Corpora
- [ ] Bi-Grams
- [ ] Tri-Grams
- [ ] n-Grams
- [ ] Frequency Measures
- [ ] Time-Series Documents
- [ ] Dispersion
- [ ] Similarity Measures
- [ ] Part of Speech Tagging
- [ ] Sentiment Analysis
- [ ] Classification
- [ ] Summarization
- [ ] Document Hierarchies

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `essence` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:essence, "~> 0.1.0"}]
    end
    ```


## Examples

In the following examples we will use `test/genesis.txt`, which is a copy of
the book of genesis from the King James Bible
(http://www.gutenberg.org/ebooks/8001.txt.utf-8).

We provide a convenience method for reading the plain text of the book of
genesis into `Essence` via the method `Essence.genesis/1`

Let's first create a document from the text:

  ```elixir
  iex> document = Essence.Document.from_text Essence.genesis
  ```

We can see that the text contains 1,533 paragraphs, 1,663 sentences and 44,741 tokens.
  ```elixir
  iex> document |> Essence.Document.enumerate_tokens |> Enum.count
  iex> document |> Essence.Document.paragraphs |> Enum.count
  iex> document |> Essence.Document.sentences |> Enum.count
  ```

What might the first sentence of genesis be?
  ```elixir
  iex> Essence.Document.sentence document, 0
  ```

Now let's compute the frequency distribution for tokens in the book of genesis:
  ```elixir
  iex> fd = Essence.Vocabulary.freq_dist document
  ```

What is the vocabulary of this text?
  ```elixir
  iex> vocabulary = Essence.Vocabulary.vocabulary document
  ```
  or alternatively we can use the frequency distribution for the equivalent expression:
  ```elixir
  iex> vocabulary = Map.keys fd
  ```

What might the top 10 most frequent tokens be?
  ```elixir
  iex> vocabulary |> Enum.sort_by( fn(x) -> Map.get(fd, x) end, &>=/2 ) |> Enum.slice(1, 10)
  ["and", "the", "of", ".", "And", ":", "his", "he", "to", ";"]
  ```

Next, we can compute the lexical richness of the text:
  ```elixir
  iex> Essence.Vocabulary.lexical_richness document
  16.74438622754491
  ```
