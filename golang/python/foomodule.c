#define Py_LIMITED_API
#include <Python.h>

// static PyObject * sum(PyObject *self, PyObject *args){
//     return PyLong_FromLongLong(42);
// }

PyObject * sum(PyObject *, PyObject *);

// Workaround missing variadic function support
// https://github.com/golang/go/issues/975
int PyArg_ParseTuple_LL(PyObject * args, long long * a, long long * b) {  
    return PyArg_ParseTuple(args, "LL", a, b);
}

static PyMethodDef module_methods[] = {  
    {"sum", (PyCFunction)sum, METH_VARARGS, "Add two numbers."},
    {NULL, NULL, 0, NULL}
};

PyMODINIT_FUNC PyInit_foo(void)  
{
    PyObject *m;
    static struct PyModuleDef moduledef = {
        PyModuleDef_HEAD_INIT,
        "foo",
        "some module doc string",
        -1,
        module_methods,
        NULL,
        NULL,
        NULL,
        NULL
    };
    // Py_InitModule3(sum, module_methods, "docstring...");
    m = PyModule_Create(&moduledef);
    printf("hello world c!\n");
    
    if (m == NULL) return NULL;

    return m;
}