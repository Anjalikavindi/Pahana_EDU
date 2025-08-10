package com.myapp.util;

//import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
	
	// Store and return plain text (NOT secure, for testing only)
    public static String hashPassword(String plainText) {
        return plainText;
    }

    public static boolean checkPassword(String plainText, String storedPassword) {
        return plainText.equals(storedPassword);
    }

//	 public static String hashPassword(String plainText) {
//	        return BCrypt.hashpw(plainText, BCrypt.gensalt());
//	    }
//
//	    public static boolean checkPassword(String plainText, String hashed) {
//	        return BCrypt.checkpw(plainText, hashed);
//	    }
	    
}
