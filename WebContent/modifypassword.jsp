<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="Util.DBUtil"%>
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.sql.ResultSet"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="javax.swing.JOptionPane"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
boolean pwErr = false;//验证旧密码是否正确
boolean pwcheck = false;//验证新密码是否一致
if(request.getMethod().equalsIgnoreCase("POST")){
	String pw1 = request.getParameter("password1");
	String pw2 = request.getParameter("password2");
	String pw3 = request.getParameter("password3");
	String username = request.getParameter("username");
	Connection conn = DBUtil.getConn();
	PreparedStatement pstmt1 = conn.prepareStatement("select * from user where username=? and password=?");
	pstmt1.setString(1,username);
	pstmt1.setString(2,pw1);
	ResultSet rs1 = pstmt1.executeQuery();
	if(rs1.next()){
		if(pw2.equals(pw3)){
			PreparedStatement pstmt2 = conn.prepareStatement("update user set password=? where username=?");
			pstmt2.setString(1,pw2);
			pstmt2.setString(2,username);
			int rs2 = pstmt2.executeUpdate();
			if(rs2==1){
				JOptionPane.showMessageDialog(null, "修改成功 ", "提示", JOptionPane.INFORMATION_MESSAGE);
			    response.sendRedirect("mainpage.jsp?username="+username);	
			}else{
				pwErr = true;
			}
			DBUtil.closeStmt(pstmt2);
		}else{
			pwcheck = true;
		}
	}else{
		pwErr = true;
	}
	DBUtil.closeStmt(pstmt1);
	DBUtil.closeConn(conn);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=basePath %>"/>
<title>修改密码</title>
<link rel="stylesheet" href="layui/css/layui.css"  media="all">
<link rel="stylesheet" href="layui/css/modules/style.css"  media="all">
<style>
  .main{
    margin:0 auto;
    margin-top:70px;
    width:50%;
  }
  </style>
</head>
<body>
    <img src="img/head.jpg" width = "100%" height="170"> 
    <div>
      <ul class="layui-nav">
        <li class="layui-nav-item"><a href="">Secondary Market</a></li>
        <li class="layui-nav-item layui-this"><a href="">修改密码</a></li>
      </ul>
    </div>
<div class="layui-layer-content main">
            <fieldset class="layui-elem-field">
                <legend>修改密码</legend>
               <form class="layui-form" action="" method="POST">
                    <div class="layui-form-item">
                       <label class="layui-form-label">旧密码&nbsp;&nbsp;</label>
                          <div class="layui-input-inline">
                               <input type="password" name="password1" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                          </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">新密码&nbsp;&nbsp;</label>
                        <div class="layui-input-inline">
                             <input type="password" name="password2" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">密码 6~12位</div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">再次输入</label>
                        <div class="layui-input-inline">
                            <input type="password" name="password3" lay-verify="pass" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
                        </div>
                    <div class="layui-form-mid layui-word-aux">要与上一个密码相同</div>
                    </div>
                    <div class="layui-form-item">
                        <div>
                             <button class=" layui-input-block layui-btn" lay-submit="" lay-filter="*" onclick="check()">立即提交</button>
                             <button type="reset" class=" layui-input-block layui-btn layui-btn-primary">重置</button>
                             <a href="mainpage.jsp?username=<%=request.getParameter("username")%>" class="layui-btn" target="_blank">取消</a>
                        </div>
  </div>
</form>
            </fieldset>
    </div>         
<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form()
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //创建一个编辑器
  var editIndex = layedit.build('LAY_demo_editor');
 
  //自定义验证规则
  form.verify({
    title: function(value){
      if(value.length < 5){
        return '标题至少得5个字符啊';
      }
    }
    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
    ,content: function(value){
      layedit.sync(editIndex);
    }
  });
  //监听提交
  form.on('submit(demo1)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
  
  
});
</script>
<script type="text/javascript">
function check(){
	if(<%=pwErr%>){
		alert("旧密码错误");
	}
	if(<%=pwcheck%>){
		alert("两个密码不同");
	}
}
</script>
</body>
</html>