package wp;
import util.ConnectionPool;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;


public class PostAPI {
	public static int getBoardContentLength(String boardId) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM post WHERE boardId = ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardId);
			
			rs = stmt.executeQuery();
			rs.next();
		    return rs.getInt(1);
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	public static List<Post> getPostFormBoard(String boardId, int count, int page) throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Post> postList = new ArrayList<Post>();
		try {
			String sql = "SELECT * FROM post WHERE boardId = ? ORDER BY postNo DESC LIMIT ? OFFSET ?";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, boardId);
			stmt.setInt(2, count);
			stmt.setInt(3, (page-1)*count);
			
			rs = stmt.executeQuery();
			int skipCount = count * (page-1);
			if (skipCount < 0) skipCount = 0;
		    while(rs.next()) {
		    	Post post = new Post();
		    	modifyPost(post, rs);
		    	postList.add(post);
		    }
		    
		    return postList;
		}
		finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	public static List<Post> getRecommendPosts(int count, int page) throws NamingException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<Post> postList = new ArrayList<Post>();
		try {
			String sql = "SELECT * FROM post WHERE recommend > 9 AND ORDER BY postNo DESC";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);

			rs = stmt.executeQuery();
		    while(rs.next()) {
		    	Post post = new Post();
		    	modifyPost(post, rs);
		    	postList.add(post);
		    }
		    
		    for(int i = ((page-1)*10); i<page+count; i++) {
		    	postList.get(i);
		    }
		    
		    return postList;
		}
	    finally {
			if (rs != null) rs.close();
			if (stmt!= null) stmt.close();
			if (conn!=null) conn.close();
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
	
	private static void modifyPost(Post post, ResultSet rs) throws SQLException {
		post.setPostNo(rs.getInt(1));
    	post.setTitle(rs.getString(2));
    	post.setUserid(rs.getString(3));
    	post.setContent(rs.getString(4));
    	post.setDate(rs.getString(5));
    	post.setView(rs.getInt(6));
    	post.setRecommend(rs.getInt(7));
    	post.setBoardId(rs.getString(8));
	}
	
	public List<Comment> getComments(int postNo) throws NamingException, SQLException{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Comment> c = new ArrayList<Comment>();
		try {
			String sql = "SELECT * FROM comment WHERE ? ORDER BY date DESC";
			
			conn = ConnectionPool.get();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, postNo);

			rs = stmt.executeQuery();
		    while(rs.next()) {
		    	Comment K = new Comment();
		    	K.setPostNo(rs.getInt(1));
		    	K.setDate(rs.getString(2));
		    	K.setUserid(rs.getString(3));
		    	K.setContent(rs.getString(4));
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

	private static int nextPostNo() throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT postNo FROM post ORDER BY postNo DESC";
		conn = ConnectionPool.get();
		stmt = conn.prepareStatement(sql);
		try {
			rs = stmt.executeQuery();
			if(rs.next()) return rs.getInt(1) + 1;
			else return 1;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	
	private static String dateNow() throws NamingException, SQLException {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT NOW()";
		conn = ConnectionPool.get();
		stmt = conn.prepareStatement(sql);
		try {
			rs = stmt.executeQuery();
			if(rs.next()) return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
}
