defmodule Essence.Readability do
  @moduledoc """
  The Readbility module contains several methods for
  calculating the readability scores of a text.
  """
  alias Essence.{Document, Token}

  @doc """
  The `ari_score` method calculates the Automated Readability Index (ARI)
  of a given `Essence.Document`.

  ## Details
  The ARI uses two quantities, mu(w) and mu(s), where
  `mu(w)` is average number of letters per word in the given text and `mu(s)`
  is the average number of words per sentence in the given text.
  The ARI is then defined by the following formula:
  `ari = 4.71 * mu(w) + 0.5 * mu(s) - 21.43`

  Commonly, the ARI score is rounded up and translated by the following table:

  | ARI score | Readability Level | Reader Age |
  | --------- | ----------------- | ---------- |
  |  1        | Kindergarten      | 5-6        |
  |  2        | First Grade       | 6-7        |
  |  3        | Second Grade      | 7-8        |
  |  4        | Third Grade       | 8-9        |
  |  5        | Fourth Grade      | 9-10       |
  |  6        | Fifth Grade       | 10-11      |
  |  7        | Sixth Grade       | 11-12      |
  |  8        | Seventh Grade     | 12-13      |
  |  9        | Eighth Grade      | 13-14      |
  | 10        | Ninth Grade       | 14-15      |
  | 11        | Tenth Grade       | 15-16      |
  | 12        | Eleventh Grade    | 16-17      |
  | 13        | Twelth Grade      | 17-18      |
  | 14+       | College           | 18-22      |
  """
  def ari_score(doc = %Document{}) do
    mu_s = (doc |> Document.sentences |> Enum.map(&Enum.count/1) |> Enum.reduce(&+/2)) / (doc |> Document.sentences |> Enum.count)
    mu_w = Token.avg_word_length(doc |> Document.enumerate_tokens)
    ari = 4.71 * mu_w + 0.5 * mu_s - 21.43
    ari |> Float.ceil |> Kernel.trunc
  end

  @doc """
  The `smog_grade` method calculates the SMOG grade measure of readability that
  estimates the years of education needed to understand a piece of writing.
  The SMOG grade is commonly used in rating health messages.
  Please note that results for documents with less than 30 sentences are statistically invalid[1].

  [1] https://en.wikipedia.org/wiki/SMOG
  """
  def smog_grade(doc = %Document{}) do
    n_sentences = doc |> Document.sentences |> Enum.count
    n_polys = doc |> Document.enumerate_tokens |> Enum.filter(&Token.is_word?/1) |> Enum.filter(&Token.is_polysyllabic?(&1, 3)) |> Enum.count
    grade = 1.0430 * :math.sqrt(n_polys * 30 / n_sentences) + 3.1291
    grade
  end


  @doc """
  Gunning fog index measures the readability of English writing. The index
  estimates the years of formal education needed to understand the text on a
  first reading. A fog index of 12 requires the reading level of a U.S. high
  school senior (around 18 years old). The test was developed by Robert
  Gunning, an American businessman, in 1952.[1]

  The fog index is commonly used to confirm that text can be read easily by the
  intended audience. Texts for a wide audience generally need a fog index less
  than 12. Texts requiring near-universal understanding generally need an index
  less than 8.

  [1] DuBay, William H. (23 March 2004). "Judges Scold Lawyers for Bad
  Writing". Plain Language At Work Newsletter. Impact Information (8).

  | Fog Index | Reading level by grade |
  | --------- | ---------------------- |
  | 17        | College graduate       |
  | 16        | College senior         |
  | 15        | College junior         |
  | 14        | College sophomore      |
  | 13        | College freshman       |
  | 12        | High school senior     |
  | 11        | High school junior     |
  | 10        | High school sophomore  |
  | 9         | High school freshman   |
  | 8         | Eighth grade           |
  | 7         | Seventh grade          |
  | 6         | Sixth grade            |
  """
  def gunning_fog(doc = %Document{}) do
    n_words = doc |> Document.enumerate_tokens |> Enum.filter(&Token.is_word?/1) |> Enum.count
    n_sentences  = doc |> Document.sentences |> Enum.count
    n_complex_words = doc |> Document.enumerate_tokens |> Enum.filter(&Token.is_word?/1) |> Enum.filter(&Token.is_polysyllabic?(&1, 3)) |> Enum.count
    gf_index = 0.4 * ( (n_words / n_sentences) + 100 * (n_complex_words / n_words) )
    gf_index
  end

  @doc """
  Calculates the Dale-Chall readability score. that provides a numeric gauge of
  the comprehension difficulty that readers come upon when reading a text. It
  uses a list of 3000 words that groups of fourth-grade American students could
  reliably understand, considering any word not on that list to be difficult.

  | Score        | Notes                                                                |
  | ------------ | -------------------------------------------------------------------- |
  | 4.9 or lower | easily understood by an average 4th-grade student or lower           |
  | 5.0–5.9      | easily understood by an average 5th or 6th-grade student             |
  | 6.0–6.9      | easily understood by an average 7th or 8th-grade student             |
  | 7.0–7.9      | easily understood by an average 9th or 10th-grade student            |
  | 8.0–8.9      | easily understood by an average 11th or 12th-grade student           |
  | 9.0–9.9      | easily understood by an average 13th to 15th-grade (college) student |
  """
  def dale_chall(doc = %Document{}) do
    n_words = doc |> Document.enumerate_tokens |> Enum.filter(&Token.is_word?/1) |> Enum.count
    n_sentences  = doc |> Document.sentences |> Enum.count
    n_difficult_words = doc |> Document.enumerate_tokens |> Enum.filter(&Token.is_word?/1) |> Enum.filter(&Essence.DaleChall.is_hard_word?/1) |> Enum.count
    score = 0.1579 * (n_difficult_words / n_words * 100) + 0.0496 * (n_words / n_sentences)
    score
  end

  @doc """
  Calculates an estimate of the time it would take an average reader to read
  the given `Essence.Document`, assuming a reading `speed` of 200 words per
  minute.
  """
  def reading_time(doc = %Document{}, speed \\ 200) do
    n_words = doc |> Document.words |> Enum.count
    mins = Float.round(n_words / speed)
    mins
  end

  @doc """
  Calculates an estimate of the time it would take to read the given
  `Essence.Document` as a speech, with a speaking `speed` of 120 words per
  minute.
  """
  def speaking_time(doc = %Document{}, speed \\ 120) do
    n_words = doc |> Document.words |> Enum.count
    n_sentences = doc |> Document.sentences |> Enum.count
    mins = Float.round(n_words / speed) + n_sentences * 0.03
    mins
  end

  @doc """
  Calculates the speaking speed in words per minute, given a speech described
  by the given `Essence.Document` and the recorded `speaking_time` in minutes.
  """
  def speaking_speed(doc = %Document{}, speaking_time) do
    n_words = doc |> Document.words |> Enum.count
    n_sentences = doc |> Document.sentences |> Enum.count
    speed = Float.round(n_words / ( speaking_time - (n_sentences * 0.03) ))
    speed
  end

end
