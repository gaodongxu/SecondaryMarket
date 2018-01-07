package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.DBUtil;

/**
 * Servlet implementation class DeleteGoods
 */
@WebServlet("/DeleteGoods")
public class DeleteGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteGoods() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String gdsid=request.getParameter("gdsid");
		try {
			Connection conn = DBUtil.getConn();
			PreparedStatement pstmt = conn.prepareStatement("delete from goods where gdsid=?");
			pstmt.setInt(1,Integer.parseInt(gdsid));
		    int rs = pstmt.executeUpdate();
		    if(rs==1){
		    	System.out.println(gdsid);
		    }
			DBUtil.closeStmt(pstmt);
			DBUtil.closeConn(conn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
