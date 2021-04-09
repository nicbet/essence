[![Build Status](https://nicbet.semaphoreci.com/badges/essence/branches/master.svg?style=shields)]
![Project Stage](https://img.shields.io/badge/stage-beta-yellow.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/essence?label=essence&style=plastic)]
[![hex.pm downloads](https://img.shields.io/hexpm/dt/essence.svg)](https://hex.pm/packages/essence)

# Essence

Essence is a Natural Language Processing (NLP) and Text Summarization library for Elixir. The work is currently in very early stages.

## ToDo

- [x] Tokenization (Basic, done)
- [x] Sentence Detection and Chunking (Basic, done)
- [x] Vocabulary (Basic, done)
- [x] Documents (Draft, done)
- [x] Concordance (done)
- [x] Readability (ARI done, SMOG done, FC todo, GF done, DC done, CL done)
- [x] Reading Time estimates (how long would it take somebody to read the given text, useful for blog posts / articles)
- [x] Speaking Time estimates (how long would it take somebody to present the given content, useful for speeches, presentations)
- [ ] Text Corpora
- [x] Bi-Grams
- [x] Tri-Grams
- [x] n-Grams
- [ ] Stopwords for English
- [ ] Common Names in English (male, female, ambiguous)
- [ ] Dictionary words in English
- [x] Dale-Challe's dictionary of easy English words
- [ ] Frequency Measures: TF, TF/IDF, ...
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
      [{:essence, "~> 0.2.0"}]
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

Let's get a concordance view on 'Adam':
  ```elixir
  iex> Essence.Document.concordance(document, "Adam")

  nd brought them unto Adam to see what he would
  hem : and whatsoever Adam called every living c
  e name thereof . And Adam gave names to all cat
   the field ; but for Adam there was not found a
  p sleep to fall upon Adam , and he slept : and
  r unto the man . And Adam said , This is now bo
  ool of the day : and Adam and his wife hid them
  LORD God called unto Adam , and said unto him ,
  over thee . And unto Adam he said , Because tho
  lt thou return . And Adam called his wife's nam
  of all living . Unto Adam also and to his wife
  e tree of life . And Adam knew Eve his wife ; a
   and sevenfold . And Adam knew his wife again ;
  f the generations of Adam . In the day that God
  nd called their name Adam , in the day when the
  y were created . And Adam lived an hundred and
  th : And the days of Adam after he had begotten
  nd all the days that Adam lived were nine hundr
  ```
