defmodule Google.Protobuf.StructTest do
  use ExUnit.Case

  alias Google.Protobuf.Struct

  @basic_json """
  {
    "key_one": "value_one",
    "key_two": 1234,
    "key_three": null,
    "key_four": true
  }
  """

  @basic_elixir %{
    "key_one" => "value_one",
    "key_two" => 1234,
    "key_three" => nil,
    "key_four" => true
  }

  @advanced_json """
  {
    "key_two": [1, 2, 3, null, true, "value"],
    "key_three": {
      "key_four": "value_four",
      "key_five": {
        "key_six": 99,
        "key_seven": {
          "key_eight": "value_eight"
        }
      }
    }
  }
  """

  @advanced_elixir %{
    "key_two" => [1, 2, 3, nil, true, "value"],
    "key_three" => %{
      "key_four" => "value_four",
      "key_five" => %{
        "key_six" => 99,
        "key_seven" => %{
          "key_eight" => "value_eight"
        }
      }
    }
  }

  describe "to_map/1" do
    test "converts basic json to map" do
      assert @basic_elixir == Struct.to_map(Protobuf.JSON.decode!(@basic_json, Struct))
    end

    test "converts advanced json to map" do
      assert @advanced_elixir == Struct.to_map(Protobuf.JSON.decode!(@advanced_json, Struct))
    end
  end

  describe "from_map/1" do
    test "converts basic elixir to struct" do
      assert Protobuf.JSON.decode!(@basic_json, Struct) == Struct.from_map(@basic_elixir)
    end

    test "converts advanced elixir to struct" do
      assert Protobuf.JSON.decode!(@advanced_json, Struct) == Struct.from_map(@advanced_elixir)
    end
  end
end
