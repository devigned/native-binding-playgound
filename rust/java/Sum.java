public class Sum{
    static{
        System.loadLibrary("sum");
    }
    public static native long sum(long x, long y);

    public static void main(String args[]){
        System.out.println("Hello world from Java!");
        System.out.println(sum(40, 2));
    }
}