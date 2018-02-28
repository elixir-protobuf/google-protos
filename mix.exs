defmodule GoogleProtobuf.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_protobuf,
      name: "Google Protobuf",
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Protobuf by Google",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GoogleProtobuf, []}
    ]
  end

  defp deps do
    [
      {:protobuf, "~> 0.5"}
    ]
  end

  defp package do
    [
      maintainers: ["Tony Han"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/tony612/google-protobuf"},
      files: ~w(mix.exs README.md lib config LICENSE)
    ]
  end
end
