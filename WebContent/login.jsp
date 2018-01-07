<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="Util.DBUtil"%>
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.sql.ResultSet"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
    boolean passwordErr=false;
	if(request.getMethod().equalsIgnoreCase("POST")){
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String role=request.getParameter("role");
		Connection conn=DBUtil.getConn();
		//PreparedStatement pstmt=conn.prepareStatement("select * from user where username=?");
		PreparedStatement pstmt;
		if(role.equals("oprator")){
			pstmt=conn.prepareStatement("select * from user where username=?");
		}else{
			pstmt=conn.prepareStatement("select * from manager where managername=?");
		}
		pstmt.setString(1,username);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next()){
			String password2=rs.getString("password");
			if(password.equals(password2)){
				//request.getRequestDispatcher("mainpage.jsp").forward(request, response);
				//request.setAttribute("username", username);
				if(role.equals("oprator")){
					response.sendRedirect("mainpage.jsp?username="+username);
				}else{
					response.sendRedirect("managerpage.jsp?managername="+username);
				}
				//response.sendRedirect("mainpage.jsp?username="+username);
				DBUtil.closeResultSet(rs);
				DBUtil.closeStmt(pstmt);
				DBUtil.closeConn(conn);
			}else{
				passwordErr=true;
			}
		}else{
			passwordErr=true;
		}
		DBUtil.closeResultSet(rs);
		DBUtil.closeStmt(pstmt);
		DBUtil.closeConn(conn);
		
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=basePath %>"/>
<title>登录</title>
<link rel="stylesheet" href="layui/css/layui.css"  media="all">
<link rel="stylesheet" href="layui/css/modules/style.css"  media="all">
<style>
  .main{
    margin:0 auto;
    margin-top:70px;
    width:30%;
  }
  .div-inline{
    display:inline;
  }
  </style>
</head>
<body>
    <img src="img/head.jpg" width = "100%" height="170"> 
    <div>
      <ul class="layui-nav">
        <li class="layui-nav-item">Secondary Market&nbsp;&nbsp;&nbsp;&nbsp;</li>
        <li class="layui-nav-item layui-this">&nbsp;&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;&nbsp;&nbsp;</li>
      </ul>
    </div>

    <div class="layui-layer-content main">
            <fieldset class="layui-elem-field">
                <legend>登陆</legend>
                <div class="layui-field-box">
                    <form action="login.jsp" method="POST" class="layui-form">
                        <div class="layui-form-item">
                            <label class="layui-form-label" for="id">用户名</label>
                            <div class="layui-input-block">
                                <input type="text" id="username" name="username" placeholder="输入用户名" required="true" class="layui-input" value="Tom">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" for="password">密码</label>
                            <div class="layui-input-block">
                                <input type="password" id="password" name="password" placeholder="输入密码" required="true" class="layui-input" value="123456">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">角色</label>                        
                            <div class="layui-input-block">
                                <input type="radio" id="oprator" name="role" value="oprator" title="会员" checked>
                                <input type="radio" id="manager" name="role" value="account" title="管理员" >
                            </div> 
                        </div>
                        <div class="layui-form-item layui-input-block div-inline">
                            <button class="layui-btn" lay-submit lay-filter="*">登陆</button>
                            <a href="register.jsp" class="layui-btn"><input type="button">注册</input></a>
                        </div>
                    </form>
                </div>
            </fieldset>
    </div>
    
    <script type="text/javascript" src="layui/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="layui/layui.js"></script>
    <script tpye="text/javascript">
        layui.use('element', function () {
            var element = layui.element();

        });
        layui.use('form', function () {
            var form = layui.form(); //只有执行了这一步，部分表单元素才会修饰成功

            //……
        });
    </script>
    <script type="text/javascript">
    function checkPassword(){
    	if(<%=passwordErr%>){
    		alert("您的用户名不正确或您的密码不正确或您的角色选择错误");
    	}
    }
    checkPassword();
    </script>
</body>
</html>