<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=GB2312" pageEncoding="utf-8"%>
<%@ page language="java" import="Util.DBUtil"%>
<%@ page language="java" import="Enity.Goods"%>
<%@ page language="java" import="java.sql.Connection"%>
<%@ page language="java" import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.sql.ResultSet"%>
<%@ page language="java" import="javax.swing.JOptionPane"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
     response.setContentType("text/html;charset=GB2312");
     response.setContentType("text/html;charset=GB2312");
     response.setCharacterEncoding("GB2312");
     request.setCharacterEncoding("GB2312");
     if(request.getMethod().equalsIgnoreCase("POST")){
    	 String gdsname = request.getParameter("gdsname");
    	 String gdsprice = request.getParameter("gdsprice");
    	 String gdsimg = request.getParameter("imgUrl");
    	 String gdshost = request.getParameter("username");
    	 String clsfcid = request.getParameter("gdsclsfcid");
    	 try{
    		 Connection conn = DBUtil.getConn();
        	 PreparedStatement stmt = conn.prepareStatement("insert into goods(gdsname,gdsprice,gdsimg,gdshost,gdsclsfcid,state) values(?,?,?,?,?,?)");
        	 stmt.setString(1,gdsname);
        	 stmt.setString(2,gdsprice);
        	 //stmt.setInt(2,Integer.parseInt(gdsprice));
        	 stmt.setString(3,gdsimg);
        	 stmt.setString(4,gdshost);
        	 stmt.setString(5,clsfcid);
        	 //stmt.setInt(5,Integer.parseInt(clsfcid));
        	 stmt.setString(6,"1");
        	 int rs = stmt.executeUpdate();
        	 if(rs==1){
        		 JOptionPane.showMessageDialog(null, "添加成功 ", "提示", JOptionPane.INFORMATION_MESSAGE);
        		 response.sendRedirect("mystore.jsp?username="+gdshost);
        	 }else{
        		 JOptionPane.showMessageDialog(null, "添加失败 ", "提示", JOptionPane.INFORMATION_MESSAGE);
        	 }
        	 DBUtil.closeStmt(stmt);
        	 DBUtil.closeConn(conn);
    	 } catch (Exception e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	  
    	 /* ResultSet rsset = pstmt.executeQuery();
    	 if(rsset.next()){
    		 JOptionPane.showMessageDialog(null, "添加成功 ", "提示", JOptionPane.INFORMATION_MESSAGE);
    	 }
    	 DBUtil.closeResultSet(rsset); */
    	 
     }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
<base href="<%=basePath %>"/>
<title>添加商品</title>
<link rel="stylesheet" href="layui/css/layui.css"  media="all">
<link rel="stylesheet" href="layui/css/modules/style.css"  media="all">
<style>
  .main{
    margin:0 auto;
    margin-top:70px;
    width:30%;
  }
  .img{
  margin:center;
    margin-left: 110px;
  }
</style>
</head>
<body>
    <img src="img/head.jpg" width = "100%" height="170"> 
    <div>
      <ul class="layui-nav">
        <li class="layui-nav-item"><a href="">Secondary Market</a></li>
        <li class="layui-nav-item layui-this"><a href="">添加商品</a></li>
      </ul>
    </div>
    <div class="layui-layer-content main">
      <fieldset class="layui-elem-field">
        <legend>添加商品</legend>
        <form class="layui-form" action="" method="POST">
          <div class="layui-form-item">
            <label class="layui-form-label">商品名&nbsp;&nbsp;</label>
            <div class="layui-input-block" style="width:190px">
              <input type="text" id="gdsname" name="gdsname" lay-verify="required" placeholder="请输入商品名称" autocomplete="off" class="layui-input" >
            </div>
          </div>
        <div class="layui-form-item">
          <label class="layui-form-label">商品价格&nbsp;&nbsp;&nbsp;&nbsp;</label>
          <div class="layui-input-inline">
            <input type="text" id="gdsprice" name="gdsprice" lay-verify="required" placeholder="请输入一个大于零的数" autocomplete="off" class="layui-input">
          </div>
        </div>
        <div class="layui-form-item">
          <label class="layui-form-label">商品类别&nbsp;</label>
            <div class="layui-input-inline">
            <select id="gdsclsfcid" name="gdsclsfcid">
              <option value="">分类</option>
              <option value="1" selected="">专业类书籍</option>
              <option value="2">非专业类书籍</option>
              <option value="3">文具</option>
              <option value="4">生活用品</option>
            </select>
        </div>
        <div class="layui-form-item">
           <div class="layui-input-inline">
           <label class="layui-form-label"></label>
              <a  class="img"><input type="file"  id="test" name="file" class="layui-upload-file " lay-title="添加一个碉堡了的图片" ></a>
              <input type="hidden" id="imgUrl" name="imgUrl"/>
           </div>
        </div>
        
    </div>
    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn" lay-submit="" lay-filter="">立即上传</button>
        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
      </div>
    </div>
</form>
</fieldset>
</div>         
<script type="text/javascript" src="layui/jquery-3.2.1.min.js"></script>
<script src="layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
layui.use('upload', function(){
	  /* layui.upload({
	    url: '' //上传接口
	    ,success: function(res){ //上传成功后的回调
	      console.log(res)
	    }
	  }); */
	  
	  layui.upload({
	    url: 'addGoods'
	    //,elem: '#test' //指定原始元素，默认直接查找class="layui-upload-file"
	    ,method: 'post' //上传接口的http类型
	    ,success: function(res){
	    $("#imgUrl").val(res.url);
	      console.log(res);
	    }
	  });
	});
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


</body>
</html>