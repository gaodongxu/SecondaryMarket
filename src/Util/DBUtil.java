package Util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Properties;

public class DBUtil {

	private static final String driver;
	private static final String connURL;
	private static final String username;
	private static final String password;

	static {
		Properties properties = new Properties();
		//DBUtil.class.getClassLoader();
		// TODO file path should be consider again, classpath will be changed
		// when deploy
		driver = "com.mysql.jdbc.Driver";
		connURL = "jdbc:mysql://localhost:3306/secondarymarket?useUnicode=true&useSSL=false&characterEncoding=UTF-8";
		username = "root";
		password = "1q2w3e4r5t";
	}

	/**
	 * 测试程序
	 * 
	 * @param args
	 * @throws SQLException
	 */
	public static void main(String[] args) throws SQLException {
		Connection conn = getConn();
		PreparedStatement pstmt=conn.prepareStatement("insert into finance (finance_company_id,finance_amount,finance_status,finance_date,finance_oprator_id)"
				+ "values(140101,1,'Waitconfirm',?,'dididalian')");
		pstmt.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
		pstmt.execute();
		pstmt.close();
		System.out.println(conn);
		closeConn(conn);
	}

	public static Connection getConn() throws SQLException {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO log it
			System.out.println("jdbc Mysql driver error");
			e.printStackTrace();
		}
		return DriverManager.getConnection(connURL, username, password);
	}

	public static void closeConn(Connection conn) {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			// TODO log it
			System.out.println("close Connection error");
			e.printStackTrace();
		} finally {
			conn = null;
		}
	}

	public static void closeStmt(Statement stmt) {
		try {
			if (stmt != null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			// TODO log it
			System.out.println("close statement error");
			e.printStackTrace();
		} finally {
			stmt = null;
		}
	}

	public static void closeResultSet(ResultSet rs) {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
		} catch (SQLException e) {
			// TODO log it
			System.out.println("close ResultSet error");
			e.printStackTrace();
		} finally {
			rs = null;
		}
	}

}
