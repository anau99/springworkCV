package springwork.datastructures;

import java.util.Base64;

public class Base64Encoder {
    public static String encode(byte[] data) {
        return Base64.getEncoder().encodeToString(data);
    }
}
