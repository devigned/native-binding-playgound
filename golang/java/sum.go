package main

// #cgo CFLAGS: -I/usr/lib/jvm/java-7-openjdk-amd64/include
// #cgo CFLAGS: -I/usr/lib/jvm/java-7-openjdk-amd64/include/linux
// #include <jni.h>
import "C"
import "fmt"

//export Java_Sum_sum
func Java_Sum_sum(env *C.JNIEnv, clazz C.jclass, x C.jlong, y C.jlong) C.jlong {
	fmt.Println("Hello from Go!")
	return x + y
}

func main() {}
