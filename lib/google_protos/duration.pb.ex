defmodule Google.Protobuf.Duration do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32

  @doc """
  Converts a `Google.Protobuf.Duration` to a value and `System.time_unit()`.

  ## Examples

      iex> Duration.to_time_unit(%Duration{seconds: 10})
      {10, :second}

      iex> Duration.to_time_unit(%Duration{seconds: 20, nanos: 100})
      {20_000_000_100, :nanosecond}

  """
  @spec to_time_unit(__MODULE__.t()) :: {integer(), System.time_unit()}
  def to_time_unit(%{seconds: seconds, nanos: 0}) do
    {seconds, :second}
  end

  def to_time_unit(%{seconds: seconds, nanos: nanos}) do
    {seconds * 1_000_000_000 + nanos, :nanosecond}
  end

  @doc """
  Converts a value and `System.time_unit()` to a `Google.Protobuf.Duration`.

  ## Examples

      iex> Duration.from_time_unit(11, :second)
      %Duration{seconds: 11}

      iex> Duration.from_time_unit(11_111_111, :microsecond)
      %Duration{seconds: 11, nanos: 111_111_000}

  """
  @spec from_time_unit(integer(), System.time_unit()) :: __MODULE__.t()
  def from_time_unit(seconds, :second) do
    struct(__MODULE__, %{
      seconds: seconds
    })
  end

  def from_time_unit(millisecond, :millisecond) do
    struct(__MODULE__, %{
      seconds: div(millisecond, 1_000),
      nanos: rem(millisecond, 1_000) * 1_000_000
    })
  end

  def from_time_unit(millisecond, :microsecond) do
    struct(__MODULE__, %{
      seconds: div(millisecond, 1_000_000),
      nanos: rem(millisecond, 1_000_000) * 1_000
    })
  end

  def from_time_unit(millisecond, :nanosecond) do
    struct(__MODULE__, %{
      seconds: div(millisecond, 1_000_000_000),
      nanos: rem(millisecond, 1_000_000_000)
    })
  end
end