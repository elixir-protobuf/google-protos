#!/bin/bash

PROTOS=("
    protobuf/src/google/protobuf/any.proto
    protobuf/src/google/protobuf/duration.proto
    protobuf/src/google/protobuf/empty.proto
    protobuf/src/google/protobuf/field_mask.proto
    protobuf/src/google/protobuf/struct.proto
    protobuf/src/google/protobuf/timestamp.proto
    protobuf/src/google/protobuf/wrappers.proto
")

rm -rf ./lib/google_protos/*.pb.ex

for file in $PROTOS; do
  protoc -I ./protobuf/src/google/protobuf/ --elixir_out=plugins=grpc:./lib/google_protos $file
done

for template_file in priv/templates/*.pb.ex; do
  file_name=$(basename "$template_file")
  replacement_file="lib/google_protos/$file_name"

  if [ -f "$replacement_file" ]; then
    for module in $(sed -n -E "s/defmodule\s(.+)\sdo/\1/p" "$template_file"); do
      replacement_text=$(cat "$template_file" | sed -n "/^defmodule\s$module\sdo$/,/^end$/p" | sed 1,2d)
      line_to_replace=$(cat -n "$replacement_file" | sed -n "/defmodule\s$module\sdo$/,/end$/p" | grep "end" | awk '{print $1}')

      export REPLACEMENT_TEXT=$replacement_text
      perl -i -pe "s/end/\$ENV{\"REPLACEMENT_TEXT\"}/g if $. == $line_to_replace" "$replacement_file"
      unset $REPLACEMENT_TEXT
    done
  fi
done
