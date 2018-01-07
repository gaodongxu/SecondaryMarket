package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import Util.DBUtil;

/**
 * Servlet implementation class BuyGoods
 */
@WebServlet("/BuyGoods")
public class BuyGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyGoods() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String gdsid = request.getParameter("gdsid");
		try {
			Connection conn = DBUtil.getConn();
			PreparedStatement pstmt1 = conn.prepareStatement("delete from shoppingcart where gdsid =? and gdsid in (select gdsid from user,goods where username=? and user.balance>=goods.gdsprice)");
		    pstmt1.setString(1,gdsid);
		    pstmt1.setString(2,username);
			int rs1 = pstmt1.executeUpdate();
		    if(rs1==1){
		    	PreparedStatement pstmt2 = conn.prepareStatement("update user set balance=balance-(select gdsprice from goods where gdsid =?) where username=?");
		    	pstmt2.setString(1,gdsid);
		    	pstmt2.setString(2,username);
		    	PreparedStatement pstmt3 = conn.prepareStatement("insert into consumption(gdsid,username) values(?,?)");
		    	pstmt3.setString(1,gdsid);
		    	pstmt3.setString(2,username);
		    	int rs2 = pstmt2.executeUpdate();
		    	int rs3 = pstmt3.executeUpdate();
		    	PreparedStatement pstmt4 =conn.prepareStatement("select dmtNum,rmNum from address where username=?");
		    	pstmt4.setString(1,username);
		    	ResultSet rsset = pstmt4.executeQuery();
		    	if(rs2==1&&rs3==1&&rsset.next()){
		    		///JOptionPane.showInternalMessageDialog(frame, "information","information", JOptionPane.INFORMATION_MESSAGE);
		    		String dmtNum=rsset.getString("dmtNum");
		    		String rmNum=rsset.getString("rmNum");
		    		System.out.println(gdsid);
		    		JOptionPane.showMessageDialog(null, "购买成功！即将发送"+dmtNum+"舍，"+rmNum , "提示", JOptionPane.INFORMATION_MESSAGE);
		    	}
		    }else{
		    	JOptionPane.showMessageDialog(null, "余额不足", "提示", JOptionPane.ERROR_MESSAGE);
		    	//window.location.reload();
		    }
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
