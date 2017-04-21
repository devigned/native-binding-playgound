#!/usr/bin/env bash
go build -buildmode=c-shared -o foo.so &&  python -c 'import foo; print(foo.sum(2, 40))'