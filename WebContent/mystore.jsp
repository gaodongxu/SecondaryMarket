<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="Util.DBUtil"%>
<%@ page language="java" import="Enity.Goods"%>
<%@ page language="java" import="java.awt.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="javax.swing.*"%>
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
ArrayList<Goods> gdsList = new ArrayList<>();
    Connection conn = DBUtil.getConn();
    PreparedStatement pstmt = conn.prepareStatement("select gdsid,gdsimg,gdsname,gdsprice,clsfcname,state from goods,classification where goods.gdsclsfcid=classification.clsfcid and gdshost=?");
    pstmt.setString(1,request.getParameter("username"));
    ResultSet rs = pstmt.executeQuery();
    while(rs.next()){
    	int gdsid = rs.getInt("gdsid");
    	 String gdsname = rs.getString("gdsname");
    	 String gdsimg = rs.getString("gdsimg");
    	 int gdsprice = rs.getInt("gdsprice");
    	 String clsfcname = rs.getString("clsfcname"); 
    	 int state = rs.getInt("state");
    	 boolean b = false; 
    	 if(state==1){
    		 b=true;
    	 }
    	 Goods g = new Goods(gdsid,gdsname,gdsprice,gdsimg,request.getParameter("username"),clsfcname,b);
    	 gdsList.add(g);
    }
    DBUtil.closeResultSet(rs);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <base href="<%=basePath %>"/>
  <title>我的商店</title> 
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="layui/css/layui.css"  media="all">
  <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
  <style>
  .user{
    width:20%;
	float:right;
  }
  .main{
    width:78%;
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
      <a href="JavaScript:void(0)">我的商城</a>
  </ul>
<!-- right -->
  <ul class="layui-nav layui-nav-tree user" lay-filter="demo">
    <li class="layui-nav-item">
      <a id="username" href="javascript:;"></a>
      <!-- <a><%=request.getParameter("username") %></a>  -->
      <dl class="layui-nav-child">
        <dd><a href="javascript:;" onclick="balance()">余额查询</a></dd>
        <dd><a href="consumption.jsp?username=<%=request.getParameter("username")%>">消费记录</a></dd>
        <dd><a href="modifypassword.jsp?username=<%=request.getParameter("username")%>">修改密码</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a id="mystore" href="mainpage.jsp?username=">商城主页</a></li>
    <li class="layui-nav-item"><a id="shoppingcart" href="shoppingcart.jsp?username=">购物车</a></li>
    <li class="layui-nav-item"><a id="addgoods" href="addgoods.jsp?username=">添加商品</a></li>
    <li class="layui-nav-item"><a href="login.jsp">更换账号</a></li>
  </ul>
<!-- main -->
   <fieldset class="layui-elem-field layui-field-title main" style="margin-top: 50px;">
    <legend>商品信息</legend>
  </fieldset>
  <fieldset class="layui-elem-field main">
    <div class="layui-field-box">
           <table class="layui-table" lay-skin="line">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="150"> 
    <col width="150">
    <col width="150">
    <col>
  </colgroup>
  <thead>
    <tr>
      <th>商品图片</th> 
      <th>商品名</th>
      <th>商品价格</th>
      <th>分类</th>
      <th>状态</th>
      <th>删除</th>
      
    </tr> 
  </thead>
  <tbody>
    <%
    for(int i=0;i<gdsList.size();i++){
    %>
    <tr>
      <td><img src="<%=gdsList.get(i).getGdsimg()%>" width = "30" height="50"> </td>
      <td><a><%=gdsList.get(i).getGdsname()%></a></td>
      <td><a><%=gdsList.get(i).getGdsprice()%></a></td>
      <td><a><%=gdsList.get(i).getClsfcname()%></a></td>
      <td><a><%=gdsList.get(i).getState()%></a></td>
      <th><button class="layui-btn layui-btn-small layui-btn-normal deleteGoods" id="<%=gdsList.get(i).getGdsid()%>"><i class="layui-icon"></i> 删除</button></th>
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
function getUsername(){
	var username=window.location.search.substring(window.location.search.indexOf("username=")+9,window.location.search.length);
	$("#username").text(username);
	$("#mystore").attr("href",$("#mystore").attr("href")+username);
	$("#addgoods").attr("href",$("#addgoods").attr("href")+username);
	$("#shoppingcart").attr("href",$("#shoppingcart").attr("href")+username);
}
getUsername();
function balance(){
	<%
	String username = request.getParameter("username");
	//Connection conn = DBUtil.getConn();
	PreparedStatement pstmtbal = conn.prepareStatement("select * from user where username=?");
	pstmtbal.setString(1,username);
	ResultSet rs1 = pstmtbal.executeQuery();
	//String bal;
	String bal=null;
	if(rs1.next()){
		bal = rs1.getString("balance");	
		//JOptionPane.showInternalMessageDialog(null, "alert", bal, JOptionPane.ERROR_MESSAGE);
		//System.out.println("!!!!1");
	}
	DBUtil.closeResultSet(rs1);
	DBUtil.closeStmt(pstmtbal);
	DBUtil.closeConn(conn);
	%>
	confirm("您的余额："+<%=bal%>);
}
</script>
<script type="text/javascript">
$(document).ready(function(){
	$(".deleteGoods").click(function(e){
		var gdsid=$(e.target).attr("id");
		$.get("DeleteGoods?gdsid="+gdsid,function(data){
			$(e.target.parentElement.parentElement).remove();
			alert("删除成功！");
		});
	});
});
</script>
</body>
</html>


