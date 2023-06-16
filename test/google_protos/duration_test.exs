defmodule Google.Protobuf.DurationTest do
  use ExUnit.Case

  alias Google.Protobuf.Duration

  describe "to_time_unit/1" do
    test "converts to total seconds if no nanoseconds specified" do
      assert {4200, :second} == Duration.to_time_unit(%Duration{seconds: 4200})
    end

    test "converts to total nanoseconds if specified" do
      assert {20_000_000_100, :nanosecond} ==
               Duration.to_time_unit(%Duration{seconds: 20, nanos: 100})
    end
  end

  describe "from_time_unit/2" do
    test "converts :second to duration" do
      assert %Duration{seconds: 11} == Duration.from_time_unit(11, :second)
    end

    test "converts :millisecond to duration" do
      assert %Duration{seconds: 11, nanos: 111_000_000} ==
               Duration.from_time_unit(11111, :millisecond)
    end

    test "converts :microsecond to duration" do
      assert %Duration{seconds: 11, nanos: 111_111_000} ==
               Duration.from_time_unit(11_111_111, :microsecond)
    end

    test "converts :nanosecond to duration" do
      assert %Duration{seconds: 11, nanos: 111_111_111} ==
               Duration.from_time_unit(11_111_111_111, :nanosecond)
    end
  end
end
