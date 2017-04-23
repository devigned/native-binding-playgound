#![feature(libc)]
#![allow(non_snake_case, non_camel_case_types)]

extern crate libc;
extern crate jni;

// methods on.
use jni::JNIEnv;
use jni::objects::JClass;
use jni::sys::jlong;

#[no_mangle]
pub extern "C" fn Java_Sum_sum(_: *mut JNIEnv, _:JClass, a:jlong, b:jlong) -> i64 {
    println!("Hello World from Rust!");
    a + b
}