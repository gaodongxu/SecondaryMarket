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
        //PageContext��jsp�����ö�����servlet����ֱ��ʹ�ã���Ҫ��һЩ����
        JspFactory _jspxFactory = null;
         PageContext pageContext = null;
         _jspxFactory = JspFactory.getDefaultFactory();
         pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);

        smart.initialize(pageContext);//��ʼ���ϴ�����
        smart.upload();
        //IpTimeStamp its=new IpTimeStamp(InetAddress.getLocalHost().getHostAddress());//request.getRemoteAddr()����û���ip��ַ
        //System.out.println("��ȡ��ipΪ"+InetAddress.getLocalHost().getHostAddress());
        //���Ҫʵ���ļ��������ϴ�����ֻ����forѭ������getFile(0)�е�0��Ϊi����
        String ext=smart.getFiles().getFile(0).getFileExt();//��Ϊ�õ��ļ�����չ��,getFile(0)Ϊ�õ�Ψһ��һ���ϴ��ļ�
        String fileName=new Date().getTime()+"."+ext;
        //System.out.println("��ȡ ���ļ���Ϊ"+fileName);
        //this.getServletContext().getRealPath("/")Ϊ�õ�tomcat�ĸ�Ŀ¼������upload�ļ����У�java.io.File.separator��һ�ְ�ȫ����
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
