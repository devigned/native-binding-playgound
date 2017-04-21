package main

// #cgo pkg-config: python3
// #define Py_LIMITED_API
// #include <Python.h>
// int PyArg_ParseTuple_LL(PyObject *, long long *, long long *);
import "C"
import "fmt"

//export sum
func sum(self, args *C.PyObject) *C.PyObject {
	var a, b C.longlong
	fmt.Println("Hello world from Go! Hi M!")
	if C.PyArg_ParseTuple_LL(args, &a, &b) == 0 {
		return nil
	}
	return C.PyLong_FromLongLong(a + b)
}

func main() {}
