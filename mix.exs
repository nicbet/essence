defmodule Essence.Mixfile do
  use Mix.Project

  def project do
    [app: :essence,
     version: "0.2.0",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    []
  end

  defp description do
    """
    Essence is a library for Natural Language Processing
    and Text Summarization in Elixir.
    """
  end

  defp package do
    [
      name: :essence,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Nicolas Bettenburg"],
      licenses: ["MIT"],
      links: %{
        "GitHub"  => "https://github.com/nicbet/essence",
        "Docs"    => "https://nicbet.github.io/essence"
      }
    ]
  end

  defp deps do
    [ {:exprof, "~> 0.2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
