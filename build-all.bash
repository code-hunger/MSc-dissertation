#!/usr/bin/bash
set -m

mkdir -p out/

build() {
  local darkstr=$1
  local dark=${2-}
  set -ex

  typst c index.typ out/index$darkstr.pdf $dark
  typst c index.typ out/index.A5$darkstr.pdf --input format=a5 $dark
  typst c index.typ out/index.dense$darkstr.pdf --input format=2-column $dark
}

build ".soft" "" &
build ".dark" "--input dark=1" &
build "" "--input dark=0" &

wait
