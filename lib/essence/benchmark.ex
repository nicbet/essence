defmodule Essence.Benchmark do

  def from_plaintext_file_a(filename) do
    profile do
      content = File.read!(filename)
      tokens = Essence.Tokenizer.tokenize(content)
      %Essence.Document{
        type: :plain_text,
        uri: filename,
        text: content,
        tokens: tokens
      }
    end
  end

  def from_plaintext_file_b(filename) do
    profile do
      stream = Essence.stream_lines(filename)
      tokens = Essence.Tokenizer.tokenize_s(stream)
      %Essence.Document{
        type: :plain_text,
        uri: filename,
        text: "",
        tokens: tokens
      }
    end
  end

end
