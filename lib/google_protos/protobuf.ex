defmodule Google.Protobuf do
  @moduledoc """
  Protos by Google.
  """

  @doc """
  Returns a `DateTime` from `Google.Protobuf.Timestamp`.

      iex> Google.Protobuf.to_datetime!(Google.Protobuf.Timestamp.new(seconds: 5, nanos: 100))
      ~U[1970-01-01 00:00:05.000000Z]
  """
  @spec to_datetime!(timestamp :: %Google.Protobuf.Timestamp{}) :: DateTime.t()
  def to_datetime!(%Google.Protobuf.Timestamp{} = timestamp) do
    timestamp
    |> timestamp_nanoseconds()
    |> DateTime.from_unix!(:nanosecond)
  end

  @doc """
  Returns a `DateTime` from `Google.Protobuf.Timestamp`.

      iex> Google.Protobuf.to_datetime(Google.Protobuf.Timestamp.new(seconds: 5, nanos: 100))
      {:ok, ~U[1970-01-01 00:00:05.000000Z]}
  """
  @spec to_datetime(timestamp :: %Google.Protobuf.Timestamp{}) :: DateTime.t()
  def to_datetime(%Google.Protobuf.Timestamp{} = timestamp) do
    timestamp
    |> timestamp_nanoseconds()
    |> DateTime.from_unix(:nanosecond)
  end

  defp timestamp_nanoseconds(timestamp) do
    timestamp.seconds * 1_000_000_000 + timestamp.nanos
  end
end
