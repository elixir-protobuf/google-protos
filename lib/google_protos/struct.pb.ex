defmodule Google.Protobuf.NullValue do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :NULL_VALUE, 0
end

defmodule Google.Protobuf.Struct.FieldsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: Google.Protobuf.Value
end

defmodule Google.Protobuf.Struct do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :fields, 1, repeated: true, type: Google.Protobuf.Struct.FieldsEntry, map: true

  @doc """
  Converts a `Google.Protobuf.Struct` to a `map()`.

  ## Examples

      iex> Struct.to_map(%Struct{})
      %{}

  """
  @spec to_map(__MODULE__.t()) :: map()
  def to_map(struct) do
    Map.new(struct.fields, fn {k, v} ->
      {k, to_map_value(v)}
    end)
  end

  defp to_map_value(%{kind: {:null_value, :NULL_VALUE}}), do: nil
  defp to_map_value(%{kind: {:number_value, value}}), do: value
  defp to_map_value(%{kind: {:string_value, value}}), do: value
  defp to_map_value(%{kind: {:bool_value, value}}), do: value

  defp to_map_value(%{kind: {:struct_value, struct}}),
    do: to_map(struct)

  defp to_map_value(%{kind: {:list_value, %{values: values}}}),
    do: Enum.map(values, &to_map_value/1)

  @doc """
  Converts a `map()` to a `Google.Protobuf.Struct`.

  ## Examples

      iex> Struct.from_map(%{key: "value"})
      %Struct{}

  """
  @spec from_map(map()) :: __MODULE__.t()
  def from_map(map) do
    struct(__MODULE__, %{
      fields:
        Map.new(map, fn {k, v} ->
          {to_string(k), from_map_value(v)}
        end)
    })
  end

  defp from_map_value(nil) do
    struct(Google.Protobuf.Value, %{kind: {:null_value, :NULL_VALUE}})
  end

  defp from_map_value(value) when is_number(value) do
    struct(Google.Protobuf.Value, %{kind: {:number_value, value}})
  end

  defp from_map_value(value) when is_binary(value) do
    struct(Google.Protobuf.Value, %{kind: {:string_value, value}})
  end

  defp from_map_value(value) when is_boolean(value) do
    struct(Google.Protobuf.Value, %{kind: {:bool_value, value}})
  end

  defp from_map_value(value) when is_map(value) do
    struct(Google.Protobuf.Value, %{kind: {:struct_value, from_map(value)}})
  end

  defp from_map_value(value) when is_list(value) do
    struct(Google.Protobuf.Value, %{
      kind:
        {:list_value,
         struct(Google.Protobuf.ListValue, %{
           values: Enum.map(value, &from_map_value/1)
         })}
    })
  end
end

defmodule Google.Protobuf.Value do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :kind, 0

  field :null_value, 1,
    type: Google.Protobuf.NullValue,
    json_name: "nullValue",
    enum: true,
    oneof: 0

  field :number_value, 2, type: :double, json_name: "numberValue", oneof: 0
  field :string_value, 3, type: :string, json_name: "stringValue", oneof: 0
  field :bool_value, 4, type: :bool, json_name: "boolValue", oneof: 0
  field :struct_value, 5, type: Google.Protobuf.Struct, json_name: "structValue", oneof: 0
  field :list_value, 6, type: Google.Protobuf.ListValue, json_name: "listValue", oneof: 0
end

defmodule Google.Protobuf.ListValue do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :values, 1, repeated: true, type: Google.Protobuf.Value
end
