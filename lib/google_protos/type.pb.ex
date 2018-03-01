defmodule Google.Protobuf.Type do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          fields: [Google.Protobuf.Field.t()],
          oneofs: [String.t()],
          options: [Google.Protobuf.Option.t()],
          source_context: Google.Protobuf.SourceContext.t(),
          syntax: integer
        }
  defstruct [:name, :fields, :oneofs, :options, :source_context, :syntax]

  field :name, 1, type: :string
  field :fields, 2, repeated: true, type: Google.Protobuf.Field
  field :oneofs, 3, repeated: true, type: :string
  field :options, 4, repeated: true, type: Google.Protobuf.Option
  field :source_context, 5, type: Google.Protobuf.SourceContext
  field :syntax, 6, type: Google.Protobuf.Syntax, enum: true
end

defmodule Google.Protobuf.Field do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          kind: integer,
          cardinality: integer,
          number: integer,
          name: String.t(),
          type_url: String.t(),
          oneof_index: integer,
          packed: boolean,
          options: [Google.Protobuf.Option.t()],
          json_name: String.t(),
          default_value: String.t()
        }
  defstruct [
    :kind,
    :cardinality,
    :number,
    :name,
    :type_url,
    :oneof_index,
    :packed,
    :options,
    :json_name,
    :default_value
  ]

  field :kind, 1, type: Google.Protobuf.Field.Kind, enum: true
  field :cardinality, 2, type: Google.Protobuf.Field.Cardinality, enum: true
  field :number, 3, type: :int32
  field :name, 4, type: :string
  field :type_url, 6, type: :string
  field :oneof_index, 7, type: :int32
  field :packed, 8, type: :bool
  field :options, 9, repeated: true, type: Google.Protobuf.Option
  field :json_name, 10, type: :string
  field :default_value, 11, type: :string
end

defmodule Google.Protobuf.Field.Kind do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :TYPE_UNKNOWN, 0
  field :TYPE_DOUBLE, 1
  field :TYPE_FLOAT, 2
  field :TYPE_INT64, 3
  field :TYPE_UINT64, 4
  field :TYPE_INT32, 5
  field :TYPE_FIXED64, 6
  field :TYPE_FIXED32, 7
  field :TYPE_BOOL, 8
  field :TYPE_STRING, 9
  field :TYPE_GROUP, 10
  field :TYPE_MESSAGE, 11
  field :TYPE_BYTES, 12
  field :TYPE_UINT32, 13
  field :TYPE_ENUM, 14
  field :TYPE_SFIXED32, 15
  field :TYPE_SFIXED64, 16
  field :TYPE_SINT32, 17
  field :TYPE_SINT64, 18
end

defmodule Google.Protobuf.Field.Cardinality do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :CARDINALITY_UNKNOWN, 0
  field :CARDINALITY_OPTIONAL, 1
  field :CARDINALITY_REQUIRED, 2
  field :CARDINALITY_REPEATED, 3
end

defmodule Google.Protobuf.Enum do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          enumvalue: [Google.Protobuf.EnumValue.t()],
          options: [Google.Protobuf.Option.t()],
          source_context: Google.Protobuf.SourceContext.t(),
          syntax: integer
        }
  defstruct [:name, :enumvalue, :options, :source_context, :syntax]

  field :name, 1, type: :string
  field :enumvalue, 2, repeated: true, type: Google.Protobuf.EnumValue
  field :options, 3, repeated: true, type: Google.Protobuf.Option
  field :source_context, 4, type: Google.Protobuf.SourceContext
  field :syntax, 5, type: Google.Protobuf.Syntax, enum: true
end

defmodule Google.Protobuf.EnumValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          number: integer,
          options: [Google.Protobuf.Option.t()]
        }
  defstruct [:name, :number, :options]

  field :name, 1, type: :string
  field :number, 2, type: :int32
  field :options, 3, repeated: true, type: Google.Protobuf.Option
end

defmodule Google.Protobuf.Option do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          value: Google.Protobuf.Any.t()
        }
  defstruct [:name, :value]

  field :name, 1, type: :string
  field :value, 2, type: Google.Protobuf.Any
end

defmodule Google.Protobuf.Syntax do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :SYNTAX_PROTO2, 0
  field :SYNTAX_PROTO3, 1
end
