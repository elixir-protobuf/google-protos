defmodule Google.Protobuf.Timestamp do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32

  @doc """
  Converts a `DateTime` struct to a `Google.Protobuf.Timestamp` struct.

  Note: Elixir `DateTime.from_unix!/2` will convert units to
  microseconds internally. Nanosecond precision is not guaranteed.
  See examples for details.

  ## Examples

      iex> Timestamp.to_datetime(%Timestamp{seconds: 5, nanos: 0})
      ~U[1970-01-01 00:00:05.000000Z]

      iex> one = Timestamp.to_datetime(%Timestamp{seconds: 10, nanos: 100})
      ...> two = Timestamp.to_datetime(%Timestamp{seconds: 10, nanos: 105})
      ...> DateTime.diff(one, two, :nanosecond)
      0

  """
  @spec to_datetime(__MODULE__.t()) :: DateTime.t()
  def to_datetime(%{seconds: seconds, nanos: nanos}) do
    DateTime.from_unix!(seconds * 1_000_000_000 + nanos, :nanosecond)
  end

  @doc """
  Converts a `Google.Protobuf.Timestamp` struct to a `DateTime` struct.

  ## Examples

      iex> Timestamp.from_datetime(~U[1970-01-01 00:00:05.000000Z])
      %Timestamp{seconds: 5, nanos: 0}

  """
  @spec from_datetime(DateTime.t()) :: __MODULE__.t()
  def from_datetime(%DateTime{} = datetime) do
    nanoseconds = DateTime.to_unix(datetime, :nanosecond)

    struct(__MODULE__, %{
      seconds: div(nanoseconds, 1_000_000_000),
      nanos: rem(nanoseconds, 1_000_000_000)
    })
  end
end
