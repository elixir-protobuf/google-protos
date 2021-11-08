defmodule Google.Protobuf.DoubleValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: float | :infinity | :negative_infinity | :nan
        }

  defstruct [:value]

  field :value, 1, type: :double

  def transform_module(), do: nil
end

defmodule Google.Protobuf.FloatValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: float | :infinity | :negative_infinity | :nan
        }

  defstruct [:value]

  field :value, 1, type: :float

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Int64Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: integer
        }

  defstruct [:value]

  field :value, 1, type: :int64

  def transform_module(), do: nil
end

defmodule Google.Protobuf.UInt64Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: non_neg_integer
        }

  defstruct [:value]

  field :value, 1, type: :uint64

  def transform_module(), do: nil
end

defmodule Google.Protobuf.Int32Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: integer
        }

  defstruct [:value]

  field :value, 1, type: :int32

  def transform_module(), do: nil
end

defmodule Google.Protobuf.UInt32Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: non_neg_integer
        }

  defstruct [:value]

  field :value, 1, type: :uint32

  def transform_module(), do: nil
end

defmodule Google.Protobuf.BoolValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: boolean
        }

  defstruct [:value]

  field :value, 1, type: :bool

  def transform_module(), do: nil
end

defmodule Google.Protobuf.StringValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: String.t()
        }

  defstruct [:value]

  field :value, 1, type: :string

  def transform_module(), do: nil
end

defmodule Google.Protobuf.BytesValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }

  defstruct [:value]

  field :value, 1, type: :bytes

  def transform_module(), do: nil
end
