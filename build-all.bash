#!/usr/bin/bash
set -m

for dark in "" "--input dark=1"; do
  darkstr=""
  if [ -n "$dark" ]; then
    darkstr=".dark"
  fi

  (
    set -x
    typst c index.typ index$darkstr.pdf $dark
    typst c index.typ index.A5$darkstr.pdf --input format=a5 $dark
    typst c index.typ index.dense$darkstr.pdf --input format=2-column $dark
  ) &
done

wait
