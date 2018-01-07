package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;


import java.util.Date;
/**
 * Servlet implementation class addGoods
 */
@WebServlet("/addGoods")
public class addGoods extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addGoods() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
        
        SmartUpload smart=new SmartUpload();
        try{
        //PageContext是jsp的内置对象，在servlet不能直接使用，需要做一些处理
        JspFactory _jspxFactory = null;
         PageContext pageContext = null;
         _jspxFactory = JspFactory.getDefaultFactory();
         pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);

        smart.initialize(pageContext);//初始化上传操作
        smart.upload();
        //IpTimeStamp its=new IpTimeStamp(InetAddress.getLocalHost().getHostAddress());//request.getRemoteAddr()获得用户的ip地址
        //System.out.println("获取的ip为"+InetAddress.getLocalHost().getHostAddress());
        //如果要实现文件的批量上传，则只需用for循环，将getFile(0)中的0改为i即可
        String ext=smart.getFiles().getFile(0).getFileExt();//此为得到文件的扩展名,getFile(0)为得到唯一的一个上传文件
        String fileName=new Date().getTime()+"."+ext;
        //System.out.println("获取 的文件名为"+fileName);
        //this.getServletContext().getRealPath("/")为得到tomcat的跟目录，放于upload文件夹中，java.io.File.separator是一种安全操作
        //String realPath="";
        //this.getServletContext().getRealPath("/")+
        smart.getFiles().getFile(0).saveAs("/img"+java.io.File.separator+fileName);
        String realPath="img/"+fileName+"";
        PrintWriter out=response.getWriter();
        //System.out.println("{\"url\":\""+realPath+"\"}");
        out.println("{\"url\":\""+realPath+"\"}");
        out.flush();
        }catch(SmartUploadException e){
        	e.printStackTrace();
        }


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doGet(request,response);
	}

}
