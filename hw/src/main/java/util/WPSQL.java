package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;

public class WPSQL {
	Connection conn;
	PreparedStatement stmt;
	ResultSet rs;

	public WPSQL(String sql) throws NamingException, SQLException {
		conn = ConnectionPool.get();
		stmt = conn.prepareStatement(sql);
		rs = null;
	}

	public WPSQL(String sql, Object...args) throws NamingException, SQLException {
		this(sql);
		setArgs(args);
	}
	
	public ResultSet query(Object...args) throws NamingException, SQLException {
		rs = stmt.executeQuery();
		return rs;
	}
	
	public boolean update(String sql, Object...args) throws SQLException, NamingException {
		int count = stmt.executeUpdate();
		return (count > 0) ? true : false;
	}
	
	public void setArgs(Object...args) throws SQLException {
		int index = 1;
		for(Object arg : args) {
			if (arg instanceof Integer) {
				stmt.setInt(index, (Integer)arg);
			} else if (arg instanceof String) {
				stmt.setString(index, (String)arg);
			}
			index++;
		}
	}
	
	public void close() throws SQLException {
		if (conn != null) conn.close();
		if (stmt != null) stmt.close();
		if (rs != null) rs.close();
	}
}
