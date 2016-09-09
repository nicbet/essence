defmodule Essence.Benchmark do
  import ExProf.Macro

  def from_plaintext_file_a(filename) do
    profile do
      content = File.read!(filename)
      tokens = Essence.Tokenizer.tokenize(content)
      %Essence.Document{
        type: :plain_text,
        uri: filename,
        text: content,
        nested_tokens: tokens
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
        nested_tokens: tokens
      }
    end
  end

end
