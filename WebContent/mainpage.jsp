<%@page import="com.sun.corba.se.impl.protocol.giopmsgheaders.Message"%>
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
   ArrayList<Goods> gdsList1= new ArrayList<Goods>();
   ArrayList<Goods> gdsList2= new ArrayList<Goods>();
   ArrayList<Goods> gdsList3= new ArrayList<Goods>();
   ArrayList<Goods> gdsList4= new ArrayList<Goods>();
   Connection conn = DBUtil.getConn();
   PreparedStatement pstmt1 = conn.prepareStatement("select gdsid,gdsimg,gdsname,gdsprice,gdshost from goods where state=1 and goods.gdsclsfcid=1 and gdshost!=?");
   pstmt1.setString(1,request.getParameter("username"));
   ResultSet rs1 = pstmt1.executeQuery();
   while(rs1.next()){
	   int gdsid = rs1.getInt("gdsid");
	   String img = rs1.getString("gdsimg");
	   String gdsname = rs1.getString("gdsname");
	   int gdsprice = rs1.getInt("gdsprice");
	   String gdshost=rs1.getString("gdshost");
	   Goods g = new Goods(gdsid,gdsname,gdsprice,img,gdshost);
	   gdsList1.add(g);
   }
   PreparedStatement pstmt2 = conn.prepareStatement("select gdsid,gdsimg,gdsname,gdsprice,gdshost from goods where state=1 and goods.gdsclsfcid=2 and gdshost!=?");
   pstmt2.setString(1,request.getParameter("username"));
   ResultSet rs2 = pstmt2.executeQuery();
   while(rs2.next()){
	   int gdsid = rs2.getInt("gdsid");
	   String img = rs2.getString("gdsimg");
	   String gdsname = rs2.getString("gdsname");
	   int gdsprice = rs2.getInt("gdsprice");
	   String gdshost=rs2.getString("gdshost");
	   Goods g = new Goods(gdsid,gdsname,gdsprice,img,gdshost);
	   gdsList2.add(g);
   }
   PreparedStatement pstmt3 = conn.prepareStatement("select gdsid,gdsimg,gdsname,gdsprice,gdshost from goods where state=1 and goods.gdsclsfcid=3 and gdshost!=?");
   pstmt3.setString(1,request.getParameter("username"));
   ResultSet rs3 = pstmt3.executeQuery();
   while(rs3.next()){
	   int gdsid = rs3.getInt("gdsid");
	   String img = rs3.getString("gdsimg");
	   String gdsname = rs3.getString("gdsname");
	   int gdsprice = rs3.getInt("gdsprice");
	   String gdshost=rs3.getString("gdshost");
	   Goods g = new Goods(gdsid,gdsname,gdsprice,img,gdshost);
	   gdsList3.add(g);
   }
   PreparedStatement pstmt4 = conn.prepareStatement("select gdsid,gdsimg,gdsname,gdsprice,gdshost from goods where state=1 and goods.gdsclsfcid=4 and gdshost!=?");
   pstmt4.setString(1,request.getParameter("username"));
   ResultSet rs4 = pstmt4.executeQuery();
   while(rs4.next()){
	   int gdsid = rs4.getInt("gdsid");
	   String img = rs4.getString("gdsimg");
	   String gdsname = rs4.getString("gdsname");
	   int gdsprice = rs4.getInt("gdsprice");
	   String gdshost=rs4.getString("gdshost");
	   Goods g = new Goods(gdsid,gdsname,gdsprice,img,gdshost);
	   gdsList4.add(g);
   }
   DBUtil.closeResultSet(rs4);
   DBUtil.closeStmt(pstmt4);
   DBUtil.closeResultSet(rs3);
   DBUtil.closeStmt(pstmt3);
   DBUtil.closeResultSet(rs2);
   DBUtil.closeStmt(pstmt2);
   DBUtil.closeResultSet(rs1);
   DBUtil.closeStmt(pstmt1);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <base href="<%=basePath %>"/>
  <title>Secondary Market</title> 
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
      <a href="JavaScript:void(0)" onclick="document.getElementById('1').scrollIntoView();">书籍</a>
      <dl class="layui-nav-child">
        <dd><a href="JavaScript:void(0)" onclick="document.getElementById('1.1').scrollIntoView();">专业类</a></dd>
        <dd><a href="JavaScript:void(0)" onclick="document.getElementById('1.2').scrollIntoView();">非专业类</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a href="JavaScript:void(0)" onclick="document.getElementById('2').scrollIntoView();">文具</a></li>
    <li class="layui-nav-item"><a href="JavaScript:void(0)" onclick="document.getElementById('3').scrollIntoView();">生活用品</a></li>
  </ul>
<!-- right -->
  <ul class="layui-nav layui-nav-tree user" lay-filter="demo">
    <li class="layui-nav-item">
      <a id="username" href="javascript:;"></a>
      <!-- <a><%=request.getParameter("username") %></a>  -->
      <dl class="layui-nav-child">
        <dd><a href="javascript:;" onclick="balance()">余额查询</a></dd>
        <dd><a href="consumption.jsp?username=<%=request.getParameter("username")%>">消费记录</a></dd>
        <dd><a id ="modify" href="modifypassword.jsp?username=">修改密码</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a id="mystore" href="mystore.jsp?username=">我的商店</a></li>
    <li class="layui-nav-item"><a id="shoppingcart" href="shoppingcart.jsp?username=">购物车</a></li>
    <li class="layui-nav-item"><a href="login.jsp">更换账号</a></li>
  </ul>
<!-- main -->
  <fieldset class="layui-elem-field layui-field-title main" style="margin-top: 50px;">
    <legend id="1">书籍</legend>
  </fieldset>
 
  <fieldset class="layui-elem-field main">
    <legend id="1.1">专业类</legend>
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
  <tbody>
    <%
    for(int i=0;i<gdsList1.size();i+=5){
    %>
    <tr>
      <td>图片</td>
      <td><img src="<%=gdsList1.get(i).getGdsimg()%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+1<gdsList1.size())?gdsList1.get(i+1).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+2<gdsList1.size())?gdsList1.get(i+2).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+3<gdsList1.size())?gdsList1.get(i+3).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+4<gdsList1.size())?gdsList1.get(i+4).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
    </tr>
    <tr>
      <td>商品名称</td>
      <td><a class="buy" id="<%=gdsList1.get(i).getGdsid()%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>" ><%=gdsList1.get(i).getGdsname()%></a></td>
      <td><a class="buy" id="<%=(i+1<gdsList1.size())?gdsList1.get(i+1).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+1<gdsList1.size())?gdsList1.get(i+1).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+2<gdsList1.size())?gdsList1.get(i+2).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+2<gdsList1.size())?gdsList1.get(i+2).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+3<gdsList1.size())?gdsList1.get(i+3).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+3<gdsList1.size())?gdsList1.get(i+3).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+4<gdsList1.size())?gdsList1.get(i+4).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+4<gdsList1.size())?gdsList1.get(i+4).getGdsname():"无"%></a></td>
    </tr>
    <tr>
      <td>价格</td>
      <td><%=gdsList1.get(i).getGdsprice()%>元</td>
      <td><%=(i+1<gdsList1.size())?gdsList1.get(i+1).getGdsprice():0%>元</td>
      <td><%=(i+2<gdsList1.size())?gdsList1.get(i+2).getGdsprice():0%>元</td>
      <td><%=(i+3<gdsList1.size())?gdsList1.get(i+3).getGdsprice():0%>元</td>
      <td><%=(i+4<gdsList1.size())?gdsList1.get(i+4).getGdsprice():0%>元</td>
    </tr>
     <%} %>
    
  </tbody>
  
</table>   
    
    </div>
  </fieldset>
  <fieldset class="layui-elem-field main">
    <legend id="1.2">非专业</legend>
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
  <tbody>
    <%
    for(int i=0;i<gdsList2.size();i+=5){
    %>
    <tr>
      <td>图片</td>
      <td><img src="<%=gdsList2.get(i).getGdsimg()%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+1<gdsList2.size())?gdsList2.get(i+1).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
　　　      <td><img src="<%=(i+2<gdsList2.size())?gdsList2.get(i+2).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+3<gdsList2.size())?gdsList2.get(i+3).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+4<gdsList2.size())?gdsList2.get(i+4).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
    </tr>
    <tr>
      <td>商品名称</td>
      <td><a class="buy" id="<%=gdsList2.get(i).getGdsid()%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>" ><%=gdsList2.get(i).getGdsname()%></a></td>
      <td><a class="buy" id="<%=(i+1<gdsList2.size())?gdsList2.get(i+1).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+1<gdsList2.size())?gdsList2.get(i+1).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+2<gdsList2.size())?gdsList2.get(i+2).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+2<gdsList2.size())?gdsList2.get(i+2).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+3<gdsList2.size())?gdsList2.get(i+3).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+3<gdsList2.size())?gdsList2.get(i+3).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+4<gdsList2.size())?gdsList2.get(i+4).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+4<gdsList2.size())?gdsList2.get(i+4).getGdsname():"无"%></a></td>
    </tr>
    <tr>
      <td>价格</td>
      <td><%=gdsList2.get(i).getGdsprice()%>元</td>
      <td><%=(i+1<gdsList2.size())?gdsList2.get(i+1).getGdsprice():0%>元</td>
      <td><%=(i+2<gdsList2.size())?gdsList2.get(i+2).getGdsprice():0%>元</td>
      <td><%=(i+3<gdsList2.size())?gdsList2.get(i+3).getGdsprice():0%>元</td>
      <td><%=(i+4<gdsList2.size())?gdsList2.get(i+4).getGdsprice():0%>元</td>
    </tr>
     <%} %>
    
  </tbody>
  
</table>   
    
    </div>
  </fieldset>
  <fieldset class="layui-elem-field layui-field-title main" style="margin-top: 50px;">
    <legend><a id="2">文具</a></legend>
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
  <tbody>
    <%
    for(int i=0;i<gdsList3.size();i+=5){
    %>
    <tr>
      <td>图片</td>
      <td><img src="<%=gdsList3.get(i).getGdsimg()%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+1<gdsList3.size())?gdsList3.get(i+1).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+2<gdsList3.size())?gdsList3.get(i+2).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+3<gdsList3.size())?gdsList3.get(i+3).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+4<gdsList3.size())?gdsList3.get(i+4).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>    
    </tr>
    <tr>
      <td>商品名称</td>
      <td><a class="buy" id="<%=gdsList3.get(i).getGdsid()%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>" ><%=gdsList3.get(i).getGdsname()%></a></td>
      <td><a class="buy" id="<%=(i+1<gdsList3.size())?gdsList3.get(i+1).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+1<gdsList3.size())?gdsList3.get(i+1).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+2<gdsList3.size())?gdsList3.get(i+2).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+2<gdsList3.size())?gdsList3.get(i+2).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+3<gdsList3.size())?gdsList3.get(i+3).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+3<gdsList3.size())?gdsList3.get(i+3).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+4<gdsList3.size())?gdsList3.get(i+4).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+4<gdsList3.size())?gdsList3.get(i+4).getGdsname():"无"%></a></td>
    </tr>
    <tr>
      <td>价格</td>
      <td><%=gdsList3.get(i).getGdsprice()%>元</td>
      <td><%=(i+1<gdsList3.size())?gdsList3.get(i+1).getGdsprice():0%>元</td>
      <td><%=(i+2<gdsList3.size())?gdsList3.get(i+2).getGdsprice():0%>元</td>
      <td><%=(i+3<gdsList3.size())?gdsList3.get(i+3).getGdsprice():0%>元</td>
      <td><%=(i+4<gdsList3.size())?gdsList3.get(i+4).getGdsprice():0%>元</td>
    </tr>
      
     <%} %>
    
  </tbody>
  
</table>   
    </div>
  </fieldset>
    
  <fieldset class="layui-elem-field layui-field-title main" style="margin-top: 50px;">
    <legend id="3">生活用品</legend>
  </fieldset>
  <fieldset class="layui-elem-field main">
    <div class="layui-field-box">
         <table class="layui-table" lay-skin="line" style="table-layout:fixed;">
  <colgroup>
    <col width="150">
    <col width="150">
    <col width="150">
    <col width="150">
    <col width="150">
    <col>
  </colgroup>
  <tbody>
    <%
    for(int i=0;i<gdsList4.size();i+=5){
    %>
    <tr>
      <td>图片</td>
      <td><img src="<%=gdsList4.get(i).getGdsimg()%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+1<gdsList4.size())?gdsList4.get(i+1).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+2<gdsList4.size())?gdsList4.get(i+2).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+3<gdsList4.size())?gdsList4.get(i+3).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
      <td><img src="<%=(i+4<gdsList4.size())?gdsList4.get(i+4).getGdsimg():"img/blank.jpg"%>" width = "30" height="50"> </td>
    </tr>
    <tr>
      <td>商品名称</td>
      <td><a class="buy" id="<%=gdsList4.get(i).getGdsid()%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>" ><%=gdsList4.get(i).getGdsname()%></a></td>
      <td><a class="buy" id="<%=(i+1<gdsList4.size())?gdsList4.get(i+1).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+1<gdsList4.size())?gdsList4.get(i+1).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+2<gdsList4.size())?gdsList4.get(i+2).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+2<gdsList4.size())?gdsList4.get(i+2).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+3<gdsList4.size())?gdsList4.get(i+3).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+3<gdsList4.size())?gdsList4.get(i+3).getGdsname():"无"%></a></td>
      <td><a class="buy" id="<%=(i+4<gdsList4.size())?gdsList4.get(i+4).getGdsid():0%>" href="mainpage.jsp?username=<%=request.getParameter("username")%>"><%=(i+4<gdsList4.size())?gdsList4.get(i+4).getGdsname():"无"%></a></td>
    </tr>
    <tr>
      <td>价格</td>
      <td><%=gdsList4.get(i).getGdsprice()%>元</td>
      <td><%=(i+1<gdsList4.size())?gdsList4.get(i+1).getGdsprice():0%>元</td>
      <td><%=(i+2<gdsList4.size())?gdsList4.get(i+2).getGdsprice():0%>元</td>
      <td><%=(i+3<gdsList4.size())?gdsList4.get(i+3).getGdsprice():0%>元</td>
      <td><%=(i+4<gdsList4.size())?gdsList4.get(i+4).getGdsprice():0%>元</td>
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
	$("#shoppingcart").attr("href",$("#shoppingcart").attr("href")+username);
	$("#modify").attr("href",$("#modify").attr("href")+username);
}
getUsername();
function balance(){
	<%
	String username = request.getParameter("username");
	//Connection conn = DBUtil.getConn();
	PreparedStatement pstmtbal = conn.prepareStatement("select * from user where username=?");
	pstmtbal.setString(1,username);
	ResultSet rs = pstmtbal.executeQuery();
	//String bal;
	String bal=null;
	if(rs.next()){
		bal = rs.getString("balance");	
		//JOptionPane.showInternalMessageDialog(null, "alert", bal, JOptionPane.ERROR_MESSAGE);
		//System.out.println("!!!!1");
	}
	DBUtil.closeResultSet(rs);
	DBUtil.closeStmt(pstmtbal);
	DBUtil.closeConn(conn);
	%>
	confirm("您的余额："+<%=bal%>);
}
$(document).ready(function(){
	$(".buy").click(function(e){
		var r = confirm("确定加入购物车？");
		if(r==true){
		var gdsid=$(e.target).attr("id");
		$.get("toShoppingcart?gdsid=" + gdsid + "&username=<%=request.getParameter("username")%>",function(data){
			alert("添加成功！"); 
		});
		}
	});
});
</script>
</body>
</html>


