#!/usr/bin/env bash
rm -f librustjavasum.so && cargo build && cp target/debug/librustjavasum.so librustjavasum.so && javac Sum.java && java -Djava.library.path=. Sum