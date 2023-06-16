# Templates

These files are placed in the Protobuf generated Elixir modules. For them to match and be inserted:

1) The template file must match the file in `lib/google_protos`.

2) The module name must match what module you want the data inserted into.

3) The template file must include `@moduledoc false` (we remove the first two lines.)
