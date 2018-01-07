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
 * Servlet implementation class OutShoppingcart
 */
@WebServlet("/OutShoppingcart")
public class OutShoppingcart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OutShoppingcart() {
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
			PreparedStatement pstmt1 = conn.prepareStatement("update goods set state=1 where gdsid=? ");
			pstmt1.setInt(1,Integer.parseInt(gdsid));
		    int rs1 = pstmt1.executeUpdate();
		    PreparedStatement pstmt2 = conn.prepareStatement("delete from shoppingcart where gdsid=?");
			pstmt2.setInt(1,Integer.parseInt(gdsid));
		    int rs2 = pstmt2.executeUpdate();
		    if(rs1==1&&rs2==1){
		    	System.out.println(gdsid);
		    }
		    DBUtil.closeStmt(pstmt2);
			DBUtil.closeStmt(pstmt1);
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
