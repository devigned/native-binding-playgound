#!/usr/bin/env bash
go build -buildmode=c-shared -o libSum.so && javac Sum.java && java -Djava.library.path=. Sum
