defmodule Google.Protobuf.SourceContext do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          file_name: String.t()
        }
  defstruct [:file_name]

  field :file_name, 1, type: :string
end
