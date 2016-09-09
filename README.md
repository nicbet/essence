[![Build Status](https://semaphoreci.com/api/v1/nicbet/essence/branches/master/shields_badge.svg)](https://semaphoreci.com/nicbet/essence)
# Essence

Essence is a Natural Language Processing (NLP) and Text Summarization library for Elixir. The work is currently in very early stages.

## ToDo

- [x] Tokenization
- [ ] Sentence Detection and Chunking
- [ ] Vocabulary
- [ ] Part of Speech Tagging
- [ ] Sentiment Analysis
- [ ] Bi-Grams
- [ ] Tri-Grams
- [ ] n-Grams
- [ ] Documents
- [ ] Corpora
- [ ] Time-Series Documents
- [ ] Document Hierarchies
- [ ] Dispersion
- [ ] Similarity Measures
- [ ] Classification
- [ ] Summarization

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `essence` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:essence, "~> 0.1.0"}]
    end
    ```

  2. Ensure `essence` is started before your application:

    ```elixir
    def application do
      [applications: [:essence]]
    end
    ```

## Examples

First, reading a plain text into Essence. In the following examples we will
use `test/genesis.txt`, which is a copy of the book of genesis
from the King James Bible (http://www.gutenberg.org/ebooks/8001.txt.utf-8)
  ```elixir
  iex> text = Essence.read_text("test/genesis.txt")
  ```

Let's first tokenize this text.
  ```elixir
  iex> tokens = Essence.Tokenizer.tokenize(text)
  ```

We can see that the text contains 44,741 tokens.
  ```elixir
  iex> tokens |> Enum.count
  ```

Now let's compute the frequency distribution for each token:
  ```elixir
  iex> fd = Essence.Vocabulary.freq_dist(tokens)
  ```

What is the vocabulary of this text?
  ```elixir
  iex> vocabulary = Essence.Vocabulary.vocabulary(tokens)
  ```

What might the top 10 most frequent tokens be?
  ```elixir
  iex> vocabulary |> Enum.sort_by( fn(x) -> Map.get(fd, x) end, &>=/2 ) |> Enum.slice(1, 10)
  ["and", "the", "of", ".", "And", ":", "his", "he", "to", ";"]
  ```

Next, we can compute the lexical richness of the text:
  ```elixir
  iex> Essence.Vocabulary.lexical_richness(text)
  16.74438622754491
  ```
