package wp;

import jakarta.servlet.http.HttpSession;
import util.ConnectionPool;

import java.sql.*;
import javax.naming.NamingException;

public class UserAPI {
	private static final String sessionId = "MEMBERID";
	
	public static boolean isSessionLogin(HttpSession session)  {
		String memberId = (String)session.getAttribute(sessionId);
	    return (memberId == null ? false : true);
	}
	
	public static String getSessionUserId(HttpSession session) {
		String UserId = (String)session.getAttribute(sessionId);
		if(UserId!= null)
			return UserId;
		else
			return "";
	}
	
	public static void setSessionUserId(HttpSession session, String id) throws NamingException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM user WHERE id = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			rs.next();
			
			session.setAttribute(sessionId, id);
		}
		finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}	    
	}
	
	public static User getSessionUser(HttpSession session) throws NamingException, SQLException {
		String id = getSessionUserId(session);
		
		return getUser(id);
	}
	
	public static boolean insertUser(String id, String pw, String name) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO user(id,pw,name) VALUES(?,?,?)";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			stmt.setString(3, name);
			
			int count = stmt.executeUpdate();
			return (count > 0) ? true : false;
		}
		finally {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
	}
	
	public static boolean deleteUser(String id) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM user WHERE id = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			int count = stmt.executeUpdate();
			return (count > 0) ? true : false;
		}
		finally {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
	}
	
	public static boolean isValidUser(String id, String pw) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT pw FROM user WHERE id = ?";

			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);

			rs = stmt.executeQuery();
			if (!rs.next()) {
				return false;
			} else if(rs.getString("pw").equals(pw)) {
				return true;
			} else {
				return false;
			}
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	public static User getUser(String id) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM user WHERE id = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			if (rs.next()) {
				return new User(rs.getString("id"), rs.getString("name"));
			} else {
				return new User(); 
			}
		}
		finally {
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		}
	}
	
	public static String getUserName(String id) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT name FROM user WHERE id = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			rs.next();
			return rs.getString(1);
			

		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	public static boolean existsUser(String id) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT id FROM user WHERE id = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			return rs.next();
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
}
