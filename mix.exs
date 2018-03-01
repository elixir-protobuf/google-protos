defmodule GoogleProtos.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_protos,
      name: "Google Protos",
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Protos by Google",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GoogleProtos, []}
    ]
  end

  defp deps do
    [
      {:protobuf, "~> 0.5"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package do
    [
      maintainers: ["Tony Han"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tony612/google-protos"},
      files: ~w(mix.exs README.md lib config LICENSE)
    ]
  end
end
