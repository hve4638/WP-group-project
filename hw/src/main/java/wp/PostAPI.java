package wp;
import util.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

public class PostAPI {
	public static int getPostAmount(String boardId) throws NamingException, SQLException {
		WPSQL sql = new WPSQL("SELECT COUNT(*) FROM post WHERE boardId = ?");
		ResultSet rs = null;
		
		try {
			sql.setArgs(boardId);
			rs = sql.query();
			rs.next();
		    return rs.getInt(1);
		}
		finally {
			if(sql!=null) sql.close();
		}
	}
	
	public static List<Post> getPostFormBoard(String boardId, int count, int page) throws NamingException, SQLException {
		WPSQL sql = new WPSQL("SELECT * FROM post WHERE boardId = ? ORDER BY postNo DESC LIMIT ? OFFSET ?");
		List<Post> postList = new ArrayList<Post>();
		try {
			sql.setArgs(boardId, count, (page-1)*count);
			
			ResultSet rs = sql.query();
		    while(rs.next()) {
		    	Post post = new Post();
		    	modifyPost(post, rs);
		    	postList.add(post);
		    }
		    
		    return postList;
		}
		finally {
			sql.close();
		}
	}

	public static List<Post> getPostFormBoard(String boardId, int count, int page, String search) throws NamingException, SQLException {
		return searchPosts(boardId, count, page, search);
	}
	
	public static List<Post> searchPosts(String boardId, int count, int page, String search) throws NamingException, SQLException {
		WPSQL sql = new WPSQL("SELECT * FROM post WHERE boardId = '"+boardId+"' AND title LIKE '%"+search+"%' ORDER BY postNo DESC LIMIT ? OFFSET ?");
		List<Post> postList = new ArrayList<Post>();
		try {
			sql.setArgs(count, (page-1)*count);
			ResultSet rs = sql.query();
		    while(rs.next()) {
		    	Post post = new Post();
		    	modifyPost(post, rs);
		    	postList.add(post);
		    }
		    
		    return postList;
		}
		finally {
			sql.close();
		}
	}
	
	public static List<Post> getRecommendPosts(int count, int page) throws NamingException, SQLException{
		WPSQL sql = null;
		List<Post> postList = new ArrayList<Post>();
		try {
			sql = new WPSQL("SELECT * FROM post WHERE recommend > 9 AND ORDER BY postNo DESC");
			ResultSet rs = sql.query();

		    while(rs.next()) {
		    	Post post = new Post();
		    	modifyPost(post, rs);
		    	postList.add(post);
		    }
		    
		    return postList;
		}
	    finally {
	    	sql.close();
		}
	}
	
	public static Post getPost(int postNo) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT * FROM post WHERE postNo =?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, postNo);
			rs = stmt.executeQuery();
			Post post = new Post();
			if (rs.next()) modifyPost(post, rs);
			
			return post;
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	private static void modifyPost(Post post, ResultSet rs) throws SQLException, NamingException {
		post.setPostNo(rs.getInt(1));
    	post.setTitle(rs.getString(2));
    	post.setContent(rs.getString(4));
    	post.setDate(rs.getString(5));
    	post.setView(rs.getInt(6));
    	post.setRecommend(rs.getInt(7));
    	post.setBoardId(rs.getString(8));
    	
    	String userId = rs.getString(3);
    	User user = UserAPI.getUser(userId);
    	post.setUser(user);
	}
	
	public static List<Comment> getComments(int postNo) throws NamingException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Comment> c = new ArrayList<Comment>();
		try {
			String sql = "SELECT * FROM comment WHERE postNo = ? ORDER BY date DESC";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, postNo);

			rs = stmt.executeQuery();
		    while(rs.next()) {
		    	Comment K = new Comment();
		    	K.setPostNo(rs.getInt(1));
		    	K.setDate(rs.getString(2));
		    	K.setContent(rs.getString(4));
		    	String uid = rs.getString(3);
		    	User user = UserAPI.getUser(uid);
		    	
		    	K.setUser(user);
		    	
		    	

		    	c.add(K);
		    }
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
		return c; 
	}
	
	public static boolean uploadPost(String boardId, String userId, String title, String Contents) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO post VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, nextPostNo());
			stmt.setString(2, title);
			stmt.setString(3, userId);
			stmt.setString(4, Contents);
			stmt.setString(5, dateNow());
			stmt.setInt(6, 0);
			stmt.setInt(7, 0);  
			stmt.setString(8, boardId);
			
			int count = stmt.executeUpdate();
			return (count > 0) ? true : false;
		}
		finally {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
	}
	
	public static boolean uploadComment(int postNo, String userId, String contents) throws NamingException, SQLException {
		WPSQL sql = null;
		try {
			sql = new WPSQL("INSERT INTO comment VALUES (?, ?, ?, ?, ?)");
			sql.setArgs(postNo, dateNow(), userId, contents, nextCommentNo());
			
			return sql.update();
		}
		finally {
			sql.close();
		}
	}


	private static int nextPostNo() throws NamingException, SQLException {
		WPSQL sql = null;
		try {
			sql = new WPSQL("SELECT postNo FROM post ORDER BY postNo DESC");
			ResultSet rs = sql.query();
			if(rs.next()) return rs.getInt(1) + 1;
			else return 1;
		} catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
		finally {
			sql.close();
		}
	}
	
	private static int nextCommentNo() throws NamingException, SQLException {
		WPSQL sql = null;
		try {
			sql = new WPSQL("SELECT id FROM comment ORDER BY id DESC");
			ResultSet rs = sql.query();
			if(rs.next()) return rs.getInt("id") + 1;
			else return 1;
		} catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
		finally {
			sql.close();
		}
	}

	
	private static String dateNow() throws NamingException, SQLException {
		WPSQL sql = null;
		try {
			sql = new WPSQL("SELECT NOW()");
			ResultSet rs = sql.query();
			if(rs.next()) return rs.getString(1);
			else return "";
		} catch(Exception e) {
			e.printStackTrace();
			return "";
		}
		finally {
			sql.close();
		}
	}
}
