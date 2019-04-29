defmodule Google.Protobuf.Any.Codec do
  defmodule UnpackError do
    defexception [:type_url, :target_module]

    def message(%{type_url: src_url, target_module: target_module}) do
      target_url = target_module.type_url()
      "Tried to unpack a message with url #{src_url} into a Protobuf message with url #{target_url}"
    end
  end

  def unpack(%Google.Protobuf.Any{type_url: type_url, value: data},
             %{:__struct__ => mod} = target_data) do
    if type_url !== mod.type_url() do
      raise UnpackError, type_url: type_url, target_module: mod
    else
      Map.merge(target_data, mod.decode(data))
    end
  end

  def pack(%{:__struct__ => mod} = data) do
    %Google.Protobuf.Any{
      type_url: mod.type_url(),
      value: mod.encode(data)
    }
  end
end
