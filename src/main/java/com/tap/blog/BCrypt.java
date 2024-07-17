package main.java.com.tap.blog;

import java.security.SecureRandom;
import java.util.Base64;

public class BCrypt {
   
   
	 static String gensalt() {
        int logRounds = 10; // Default value
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);
        return "$2a$" + logRounds + "$" + Base64.getEncoder().encodeToString(salt).substring(0, 22);
    }

    // Hardcoded hashpw method
     static String hashpw(String password, String salt) {
        // Simulate bcrypt hashing for educational purposes
        String saltPart = salt.substring(0, 29); // Extract the salt part
        String hashed = saltPart + Base64.getEncoder().encodeToString((password + saltPart).getBytes());
        return hashed.substring(0, Math.min(hashed.length(), 60)); // Truncate to 60 characters
    }

    // Hardcoded checkpw method
     static boolean checkpw(String password, String hashed) {
        String saltPart = hashed.substring(0, 29); // Extract the salt part
        String expectedHash = saltPart + Base64.getEncoder().encodeToString((password + saltPart).getBytes());
        return hashed.equals(expectedHash);
    }


	

	
}

