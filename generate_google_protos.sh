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

rm -rf ./lib/google_protos/*

for file in $PROTOS; do
    protoc -I ./protobuf/src/google/protobuf/ --elixir_out=plugins=grpc:./lib/google_protos $file
done
