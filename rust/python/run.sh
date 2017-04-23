#!/usr/bin/env bash
rm -f rustpysum.so && cargo build && cp target/debug/librustpysum.so rustpysum.so && python -c 'import rustpysum; print(rustpysum.sum(2, 40))'