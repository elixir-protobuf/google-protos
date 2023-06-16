defmodule Google.Protobuf.TimestampTest do
  use ExUnit.Case

  alias Google.Protobuf.Timestamp

  describe "to_datetime/1" do
    test "converts to DateTime" do
      assert ~U[1970-01-01 00:00:05.000000Z] ==
               Timestamp.to_datetime(%Timestamp{seconds: 5, nanos: 0})
    end

    test "nanosecond precision" do
      one = Timestamp.to_datetime(%Timestamp{seconds: 10, nanos: 100})
      two = Timestamp.to_datetime(%Timestamp{seconds: 10, nanos: 105})
      assert 0 == DateTime.diff(one, two, :nanosecond)
    end
  end

  describe "from_datetime/1" do
    test "converts from DateTime" do
      assert %Timestamp{seconds: 5, nanos: 0} ==
               Timestamp.from_datetime(~U[1970-01-01 00:00:05.000000Z])
    end
  end
end
