# Google Protos

For Elixir files generated from [Google's protobuf files](https://github.com/google/protobuf/tree/master/src/google/protobuf) using [protobuf-elixir](https://github.com/tony612/protobuf-elixir).

## How-To

### Convert `Google.Protobuf.Timestamp` to `DateTime`

1. Convert timestamp seconds to nanoseconds.
2. Add the timestamp nanos.
3. Convert to `DateTime` using `DateTime.from_unix!/2`.

```elixir
timestamp = Google.Protobuf.Timestamp.new(seconds: 5, nanos: 100)
DateTime.from_unix!(timestamp.seconds * 1_000_000_000 + timestamp.nanos, :nanosecond)
```
