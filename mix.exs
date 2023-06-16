defmodule GoogleProtos.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_protos,
      name: "Google Protos",
      version: "0.3.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: "Protos by Google",
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:protobuf, "~> 0.12"},
      {:ex_doc, "~> 0.29", only: :dev},
      {:jason, "~> 1.4", only: :test}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md": [filename: "overview", title: "Overview"]
      ],
      main: "overview"
    ]
  end

  defp package do
    [
      maintainers: ["Tony Han", "Andrea Leopardi"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/elixir-protobuf/google-protos"},
      files: ~w(mix.exs README.md lib LICENSE)
    ]
  end
end
