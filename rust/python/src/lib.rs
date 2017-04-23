#[macro_use] extern crate cpython;

use cpython::{PyResult, Python};

// add bindings to the generated python module
py_module_initializer!(librustpysum, initlibrustpysum, PyInit_rustpysum, |py, m| {
    try!(m.add(py, "__doc__", "This module is implemented in Rust."));
    try!(m.add(py, "sum", py_fn!(py, sum_py(a: i64, b:i64))));
    Ok(())
});

// logic implemented as a normal rust function
fn sum(a:i64, b:i64) -> i64 {
    println!("Hello world from Rust!");
    a + b
}

// rust-cpython aware function. All of our python interface could be
// declared in a separate module.
// Note that the py_fn!() macro automatically converts the arguments from
// Python objects to Rust values; and the Rust return value back into a Python object.
fn sum_py(_: Python, a:i64, b:i64) -> PyResult<i64> {
    let out = sum(a, b);
    Ok(out)
}