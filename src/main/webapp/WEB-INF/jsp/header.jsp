<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<link href="./static/css/header.css" rel="stylesheet">
<title>header</title>


</head>
<body>
<div id="user">
	<div id="userLogin">欢迎访问:
	<c:choose>
		<c:when test="${user==null }">
			<a href="http://localhost:8080/MyOil/tologin" v-on:click="login"><span class="glyphicon glyphicon-user"></span>登陆</a>
		</c:when>
		<c:otherwise>
			<a href="http://localhost:8080/MyOil/user"><span class="glyphicon glyphicon-user"></span>${user.username }</a>
		</c:otherwise>
	</c:choose>
	</div>
	<c:if test="${user!=null }">
	<div id="cart" style="margin-left:30px;font-size:12px;float:left;margin-top:8px;">
		<a href="http://localhost:8080/MyOil/cart"><span class="glyphicon glyphicon-shopping-cart"></span></a>
	</div>
	</c:if>
	<div id="customService">
		服务热线：18852735045 &nbsp; &nbsp;
		<a href="#"><img alt="" src="./static/img/qq.jpg">&nbsp;陈先生</a> &nbsp;
		<a href="#"><img alt="" src="./static/img/qq.jpg">&nbsp;王先生</a>
	</div>
	
</div>

<div  id="heads">
  <div>加油站管理系统</div>
</div>
<div class="block"></div>
<div id="nav">
	<a href="http://localhost:8080/MyOil/index"><span class="glyphicon glyphicon-home"></span>首页</a> | 
	<a href="http://localhost:8080/MyOil/shopOnline">网上便利店</a>|
	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=economics">石油财经</a> |
	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=decision">决策系统</a>|
	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=technology">设备技术</a>|
	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=news">新闻资讯</a>|
	<a href="#">加入油联</a>|
</div>
</body>
</html>