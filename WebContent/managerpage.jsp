<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="Enity.User"%>
<%@ page language="java" import="Enity.Goods"%>
<%@ page language="java" import="Util.DBUtil"%>
<%@ page language="java" import="javax.swing.JOptionPane"%>
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.sql.ResultSet"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
     ArrayList<User> userList = new ArrayList<User>();
     ArrayList<Goods> goodsList = new ArrayList<Goods>();
     Connection conn = DBUtil.getConn();
     PreparedStatement pstmt1 = conn.prepareStatement("select * from user");
     ResultSet rs1 = pstmt1.executeQuery();
     while(rs1.next()){
    	 String uname = rs1.getString("username");
    	 String pw = rs1.getString("password");
    	 int bal = rs1.getInt("balance");
    	 User u = new User(uname,pw,bal);
    	 userList.add(u);
     }
     PreparedStatement pstmt2 = conn.prepareStatement("select * from goods");
     ResultSet rs2 = pstmt2.executeQuery();
     while(rs2.next()){
    	 int gdsid = rs2.getInt("gdsid");
    	 String gdsname = rs2.getString("gdsname");
    	 String gdsimg = rs2.getString("gdsimg");
    	 int gdsprice = rs2.getInt("gdsprice");
    	 String gdshost = rs2.getString("gdshost");
    	 int clsfcid = rs2.getInt("gdsclsfcid");
    	 int gdsclsfcid = 0;
    	 PreparedStatement pstmt3 = conn.prepareStatement("select clsfcname from classification where clsfcid= ?");
    	 pstmt3.setInt(1, clsfcid);
         ResultSet rs3 = pstmt3.executeQuery();
         String clsfcname=null;
         if(rs3.next()){
        	 clsfcname=rs3.getString("clsfcname");
         }
         
    	 int state = rs2.getInt("state");
    	 boolean b = false; 
    	 if(state==1){
    		 b=true;
    	 }
    	 Goods g = new Goods(gdsid,gdsname,gdsprice,gdsimg,gdshost,clsfcname,b);
    	 goodsList.add(g);
     }
     DBUtil.closeResultSet(rs1);
	 DBUtil.closeStmt(pstmt1);
	 DBUtil.closeResultSet(rs2);
	 DBUtil.closeStmt(pstmt2);
	 
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <base href="<%=basePath %>"/>
  <title>管理员界面</title> 
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="layui/css/layui.css"  media="all">
  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
  <style>
  .main{
    width:60%;
  }
  .user{
    width:20%;
	float:right;
  }
  </style>
</head>
<body>
<!-- head -->      
  <img src="img/head.jpg" width = "100%" height="170"> 
  <ul class="layui-nav">
    <li class="layui-nav-item"><a href="">&nbsp;&nbsp;&nbsp;&nbsp;Secondary Market</a></li>
    <li class="layui-nav-item"><a href=""></a></li>
    <li class="layui-nav-item layui-this">
      <a href="JavaScript:void(0)" onclick="document.getElementById('1').scrollIntoView();">用户信息</a>
    </li>
    <li class="layui-nav-item"><a href="JavaScript:void(0)" onclick="document.getElementById('2').scrollIntoView();">商品信息</a></li>
  </ul>
<!-- main -->
  <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
    <legend id="1">用户信息</legend>
  </fieldset>
 
  <fieldset class="layui-elem-field main">
    <div class="layui-field-box">
         <table class="layui-table" lay-skin="line">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="150">
    <col>
  </colgroup>
  <thead>
    <tr>
      <th>用户名</th>
      <th>密码</th>
      <th>余额</th>
      <th>删除</th>
    </tr> 
  </thead>
  <tbody>
    <%
    for(User u:userList){
    %>
    <tr>
      <td class="username"><%=u.getUsername()%></td>
      <td><%=u.getPassword()%></td>
      <td><%=u.getBalance() %></td>
      <td><button class="layui-btn layui-btn-small layui-btn-normal deleteUser" ><i class="layui-icon main"></i> 删除</button></td>
      </tr>
     <%} %>
    
  </tbody>
</table>   
    </div>
  </fieldset>
  <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
    <legend><a id="2">商品信息</a></legend>
  </fieldset>
  <fieldset class="layui-elem-field">
    <div class="layui-field-box">
           <table class="layui-table" lay-skin="line">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="200">
    <col>
  </colgroup>
  <thead>
    <tr>
      <th>商品标号</th>  
      <th>商品名</th>
      <th>商品价格</th>
      <th>卖家</th>
      <th>物品类别</th>
      <th>商品状态</th>
      <th>删除</th>
    </tr> 
  </thead>
  <tbody>
    <%
    for(Goods g:goodsList){
    %>
    <tr>
      <td class="gdsid"><%=g.getGdsid()%></td>
      <td><%=g.getGdsname()%></td>
      <td><%=g.getGdsprice()%></td>
      <td><%=g.getGdshost()%></td>
      <td><%=g.getClsfcname()%></td>
      <td><%=g.getState()%></td>
      <th><button class="layui-btn layui-btn-small layui-btn-normal deleteGoods"><i class="layui-icon"></i> 删除</button></th>
     </tr>
     <%} %>
    
  </tbody>
</table>   
    </div>
  </fieldset>
  
<script type="text/javascript" src="layui/jquery-3.2.1.min.js"></script>
<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use('element', function(){
  var element = layui.element(); //导航的hover效果、二级菜单等功能，需要依赖element模块
  
  //监听导航点击
  element.on('nav(demo)', function(elem){
    //console.log(elem)
    layer.msg(elem.text());
  });
});
</script>
<script type="text/javascript">

$(document).ready(function(){
	$(".deleteUser").click(function(e){
		var username=$(e.target.parentElement.parentElement).find(".username").text();
		$.get("DeleteUser?username="+username,function(data){
			$(e.target.parentElement.parentElement).remove();
			alert("删除成功！");
		});
	});
	$(".deleteGoods").click(function(e){
		var gdsid=$(e.target.parentElement.parentElement).find(".gdsid").text();
		$.get("DeleteGoods?gdsid="+gdsid,function(data){
			$(e.target.parentElement.parentElement).remove();
			alert("删除成功！");
		});
	});
});
</script>
</body>
</html>


