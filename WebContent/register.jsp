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
   boolean pwincorrect = false;
   boolean userincorrect = false;
   if(request.getMethod().equalsIgnoreCase("POST")){
	   String username = request.getParameter("username");
	   String password1 = request.getParameter("password1");
	   String password2 = request.getParameter("password2");
	   String dormitoryNum = request.getParameter("dormitoryNum");
	   String roomNum = request.getParameter("roomNum");
	   Connection conn=DBUtil.getConn();
	  /*  PreparedStatement pstmt = conn.prepareStatement("insert into user(username,password,balance) values(?,?,0);"
	         +"insert into address(username,dmtNum,rmNum) values(?,?,?)"); */
	   if(password1.equals(password2)){
		   PreparedStatement pstmt = conn.prepareStatement("select username from user where username='"+username+"'");
		   ResultSet rs=pstmt.executeQuery();
		   if(!rs.next()){
			   PreparedStatement pstmt1 = conn.prepareStatement("insert into user(username,password,balance) values(?,?,0)");
			   PreparedStatement pstmt2 = conn.prepareStatement("insert into address(username,dmtNum,rmNum) values(?,?,?)");      
			   pstmt1.setString(1,username);
			   pstmt1.setString(2,password1);
			   pstmt2.setString(1,username);
			   pstmt2.setString(2,dormitoryNum);
			   pstmt2.setString(3,roomNum); 
			   int rs1 = pstmt1.executeUpdate();
			   int rs2 = pstmt2.executeUpdate();
			   if(rs1==1&&rs2==1){
				   DBUtil.closeStmt(pstmt1);
				   DBUtil.closeConn(conn);
				   JOptionPane.showMessageDialog(null, "注册成功 ", "提示", JOptionPane.INFORMATION_MESSAGE);
				   response.sendRedirect("login.jsp");
			   }
			   DBUtil.closeStmt(pstmt2);
			   DBUtil.closeStmt(pstmt1);
		   }else{
			 userincorrect=true;  
		   }
	   }else{
		   pwincorrect=true;
	   }
	   DBUtil.closeConn(conn);
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=basePath %>"/>
<title>注册</title>
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
        <li class="layui-nav-item layui-this"><a href="">注册</a></li>
      </ul>
    </div>
    <div class="layui-layer-content main">
      <fieldset class="layui-elem-field">
        <legend>注册</legend>
        <form class="layui-form" action="" method="POST">
          <div class="layui-form-item">
            <label class="layui-form-label">用户名&nbsp;&nbsp;</label>
            <div class="layui-input-inline">
              <input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
          </div>
        <div class="layui-form-item">
          <label class="layui-form-label">密码&nbsp;&nbsp;&nbsp;&nbsp;</label>
          <div class="layui-input-inline">
            <input type="password" name="password1" lay-verify="pass" placeholder="请输入密码" autocomplete="off" class="layui-input">
          </div>
        <div class="layui-form-mid layui-word-aux">密码 6~12位</div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">再次输入</label>
          <div class="layui-input-inline">
             <input type="password" name="password2" lay-verify="pass" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
          </div>
          <div class="layui-form-mid layui-word-aux">要与上一个密码相同</div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">寝室号&nbsp;</label>
            <div class="layui-input-inline">
            <select name="dormitoryNum">
              <option value="">寝室楼号</option>
              <option value="1" selected="">1舍</option>
              <option value="2">2舍</option>
              <option value="3">3舍</option>
              <option value="4">4舍</option>
              <option value="5">5舍</option>
              <option value="6">6舍</option>
            </select>
        </div>
        <div class="layui-input-inline">
           <select name="roomNum">
             <option value="101">101</option>
             <option value="102">102</option>
             <option value="201">201</option>
             <option value="202">202</option>
             <option value="301">301</option>
             <option value="302">302</option>
           </select>
        </div>
    </div>
    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn" lay-submit="" lay-filter="">立即提交</button>
        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
function checkValue(){
    location.href="login.jsp";
}
</script>
<script type="text/javascript">
function check(){
	if(<%=pwincorrect%>){
		alert("您的两个密码不同");
	}
	if(<%=userincorrect%>){
		alert("用户名重复");
	}
}
check();
</script>

</body>
</html>