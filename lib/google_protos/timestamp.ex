defmodule Google.Protobuf.Timestamp do
  @moduledoc """
  A Timestamp represents a point in time independent of any time zone or local
  calendar, encoded as a count of seconds and fractions of seconds at
  nanosecond resolution. The count is relative to an epoch at UTC midnight on
  January 1, 1970, in the proleptic Gregorian calendar which extends the
  Gregorian calendar backwards to year one.

  All minutes are 60 seconds long. Leap seconds are "smeared" so that no leap
  second table is needed for interpretation, using a [24-hour linear
  smear](https://developers.google.com/time/smear).

  The range is from 0001-01-01T00:00:00Z to 9999-12-31T23:59:59.999999999Z. By
  restricting to that range, we ensure that we can convert to and from [RFC
  3339](https://www.ietf.org/rfc/rfc3339.txt) date strings.

  ## JSON Mapping

  In JSON format, the Timestamp type is encoded as a string in the
  [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) format. That is, the
  format is "{year}-{month}-{day}T{hour}:{min}:{sec}[.{frac_sec}]Z"
  where {year} is always expressed using four digits while {month}, {day},
  {hour}, {min}, and {sec} are zero-padded to two digits each. The fractional
  seconds, which can go up to 9 digits (i.e. up to 1 nanosecond resolution),
  are optional. The "Z" suffix indicates the timezone ("UTC"); the timezone
  is required. A proto3 JSON serializer should always use UTC (as indicated by
  "Z") when printing the Timestamp type and a proto3 JSON parser should be
  able to accept both UTC and other timezones (as indicated by an offset).

  For example, "2017-01-15T01:30:15.01Z" encodes 15.01 seconds past
  01:30 UTC on January 15, 2017.
  """

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :seconds, 1, type: :int64
  field :nanos, 2, type: :int32

  @doc """
  Converts a `DateTime` struct to a `#{__MODULE__}` struct.

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
  Converts a `#{__MODULE__}` struct to a `DateTime` struct.

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
