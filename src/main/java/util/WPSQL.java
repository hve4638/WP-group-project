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
	
	public WPSQL() {
		conn = null;
		stmt = null;
		rs = null;
	}
	
	public ResultSet Query(String sql, Object[] args) throws NamingException, SQLException {
		conn = ConnectionPool.get();
		stmt = conn.prepareStatement(sql);
		insertArgs(stmt, args);
		rs = stmt.executeQuery();
		
		return rs;
	}
	
	public boolean Update(String sql, Object[] args) throws SQLException, NamingException {
		conn = ConnectionPool.get();
		stmt = conn.prepareStatement(sql);
		insertArgs(stmt, args);
		int count = stmt.executeUpdate();
		return (count > 0) ? true : false;
	}
	
	private void insertArgs(PreparedStatement stmt, Object[] args) throws SQLException {
		int index = 1;
		for(Object arg : args) {
			if (arg instanceof Integer) {
				stmt.setInt(index, (Integer)arg);
			} else if (arg instanceof String) {
				stmt.setString(index, (String)arg);
			}
		}
	}
	
	public void close() throws SQLException {
		conn.close();
		stmt.close();
		rs.close();
	}
}
