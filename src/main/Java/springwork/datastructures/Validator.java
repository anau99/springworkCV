package springwork.datastructures;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

public class Validator {
    // Check PDF
   public boolean isPDF(byte[] bytes) {
        if (bytes.length < 5) {
            return false;
        }
        // First Byte of the file is '%PDF-'
        return (bytes[0] == '%' && bytes[1] == 'P' && bytes[2] == 'D' && bytes[3] == 'F' && bytes[4] == '-');
    }

    //Check Size
    public boolean isSizeLessThanFiveMB(@RequestParam("file") MultipartFile file){
        if (file.getSize() > 5 * 1024 * 1024) { //>5MB
            return false;
        }
        return true;
    }
}
