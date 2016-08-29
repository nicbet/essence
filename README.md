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

