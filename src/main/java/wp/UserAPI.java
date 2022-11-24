package wp;
import jakarta.servlet.http.HttpSession;

public class UserAPI {
	public static boolean isSessionLogin(HttpSession session) {
		return true;
	}
	
	public static String getSessionUserId(HttpSession session) {
		return "user-id";
	}
	
	public static void setSessionUserId(HttpSession session, String id) {
		
	}
	
	public static boolean insertUser(String id, String pw, String name) {
		return true;
	}
	
	public static boolean deleteUser(String id) {
		return true;
	}
	
	public static boolean isValidUser(String id, String pw) {
		return true;
	}
	
	public static String getUserName(String id) {
		return "user-name";
	}
	
	public static boolean existsUser(String id) {
		return true;
	}
}
