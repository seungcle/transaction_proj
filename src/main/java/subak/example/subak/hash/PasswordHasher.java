package subak.example.subak.hash;

import org.springframework.stereotype.Component;

import org.mindrot.jbcrypt.BCrypt;

@Component
public class PasswordHasher {
	public String encrypt(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}
	public boolean check(String password, String hashed) {
		return BCrypt.checkpw(password, hashed);
	}
}
