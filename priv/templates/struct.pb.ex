defmodule Google.Protobuf.Struct do
  @moduledoc false

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
