# Google Protos

For Elixir files generated from [Google's protobuf files](https://github.com/google/protobuf/tree/master/src/google/protobuf) using [protobuf-elixir](https://github.com/elixir-protobuf/protobuf).

By including `google_protos` in your `mix.exs`, you'll have access to _some_ of the `google.protobuf.*` modules already compiled to Elixir. This can help simplify your protobuf compiling pipeline. For your benefit, we also include some helper functions for converting the protobuf structs to native Elixir modules. See the documentation for more details.

## Docuemntation

Docuemntation is available on [hex.pm](https://hexdocs.pm/google_protos/).

## Usage

Include the `:google_protos` package in your `mix.exs` dependency list:

```elixir
defp deps do
  [
    {:google_protos, "~> 0.3"}
  ]
end
```

Use the `Google.Protobuf` modules. See [google_protos](https://hexdocs.pm/google_protos/) and [Elixir protobuf](https://hexdocs.pm/protobuf) documentation for more details.

## Limits

The Google Protos repository will only compile official Google protobuf messages, and will only include helper functions for _native_ Elixir modules. We do not accept PRs adding support for third party libraries (ecto, decimal, money, etc.) If there is a Google Protobuf message that maps nicely to an Elixir module where we don't include helpers, please feel free to open a PR.
