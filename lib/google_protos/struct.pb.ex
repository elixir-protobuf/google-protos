defmodule Google.Protobuf.NullValue do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :NULL_VALUE

  field :NULL_VALUE, 0
end

defmodule Google.Protobuf.Struct.FieldsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Google.Protobuf.Value.t() | nil
        }

  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: Google.Protobuf.Value

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Struct do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          fields: %{String.t() => Google.Protobuf.Value.t() | nil}
        }

  defstruct [:fields]

  field :fields, 1, repeated: true, type: Google.Protobuf.Struct.FieldsEntry, map: true

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          kind:
            {:null_value, Google.Protobuf.NullValue.t()}
            | {:number_value, float | :infinity | :negative_infinity | :nan}
            | {:string_value, String.t()}
            | {:bool_value, boolean}
            | {:struct_value, Google.Protobuf.Struct.t() | nil}
            | {:list_value, Google.Protobuf.ListValue.t() | nil}
        }

  defstruct [:kind]

  oneof :kind, 0

  field :null_value, 1,
    type: Google.Protobuf.NullValue,
    enum: true,
    json_name: "nullValue",
    oneof: 0

  field :number_value, 2, type: :double, json_name: "numberValue", oneof: 0
  field :string_value, 3, type: :string, json_name: "stringValue", oneof: 0
  field :bool_value, 4, type: :bool, json_name: "boolValue", oneof: 0
  field :struct_value, 5, type: Google.Protobuf.Struct, json_name: "structValue", oneof: 0
  field :list_value, 6, type: Google.Protobuf.ListValue, json_name: "listValue", oneof: 0

  def transform_module(), do: nil
end

defmodule Google.Protobuf.ListValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          values: [Google.Protobuf.Value.t()]
        }

  defstruct [:values]

  field :values, 1, repeated: true, type: Google.Protobuf.Value

  def transform_module(), do: nil
end
