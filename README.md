# Native Binding Playgound
Playgound for native bindings for languages (py, java, etc) with Golang and Rust.

## Want to play too?
You either need to install all of the langauge dependencies on your system or have Docker. I'd recommend Docker.
- clone the repo
- run `./build.sh && ./run.sh`

The container has all needed dependencies and will mount the repo directory into the container. 
In each language combination directory (./golang/python, ./rust/python, etc...) is a `run.sh` file. 
When you execute `run.sh`, the language combination will be built and run.

Each of the bindings is rather trivial, but it serves as a good playgound to explore native bindings.


