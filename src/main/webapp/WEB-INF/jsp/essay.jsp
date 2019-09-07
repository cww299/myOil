<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
pre {
    white-space: pre-wrap;       /* css-3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
    } 
</style>
<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">
<title>${essay.title }</title>

<link href="./static/css/essay.css" rel="stylesheet">
<%@include file="header.jsp" %>

</head>
<body>


<div id="breadcrumbNav">
	<ol class="breadcrumb">
	  <li><a href="./index">首页</a></li>
	  <li><a href="./getEssayListByCategory?category=${essay.category }">
			<c:if test="${essay.category == 'economics' }">
		  		石油财经		
		  	</c:if>
		  	<c:if test="${essay.category =='technology'}">
		  		设备技术
		  	</c:if>
		  	<c:if test="${essay.category =='decision'}">
		  		决策系统
		  	</c:if>
		  	<c:if test="${essay.category =='news'}">
		  		新闻资讯
		  	</c:if>
		  </a></li>
	  <li class="active">${essay.title } </li>
	</ol>
</div>


<div id="pageContent">
	<center>
		<div>
			<h2 class="essayTitle">${essay.title}</h2>
		</div>
		<font color="gray">
			<span class="glyphicon glyphicon-time"></span>${essay.time}
			&nbsp &nbsp &nbsp &nbsp &nbsp
			<span class="glyphicon glyphicon-eye-open"></span>${essay.views}次
			<input type="hidden" id="id" value="${essay.id }">
			<input type="hidden" id="category" value="${essay.category }">
		</font>
		<div class="essayBlock"></div>
	</center>
	<div id="essayContent">
		<pre>${essay.content}<br/><br/><br/></pre>
	</div>
	<div id="share">分享：
		<a href="#"><img width="23" src="./static/img/wechat.jpg"></a>
	    <a href="#"><img width="23" src="./static/img/webo.jpg"></a>
		<a href="#"><img src="./static/img/qq.jpg"></a>
	</div>
	<div id="befor_next"> 
		<c:choose>
			<c:when test="${beforeEssay!=NULL and beforeEssay!='' }">
				<div class="befor" >
					上一篇：<a href="http://localhost:8080/MyOil/getEssay?id=${beforeEssay.id }">${beforeEssay.title}</a></div>
			</c:when>
			<c:otherwise>
				<div class="befor" v-else>
					上一篇：<font font-weight="normal" color="gray">没有了</font>
				</div>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${nextEssay!=null and nextEssay!='' }">
				<div class="next" >
					下一篇：<a href="http://localhost:8080/MyOil/getEssay?id=${nextEssay.id }">${nextEssay.title}</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="next" v-else>
					下一篇：<font font-weight="normal" color="gray">没有了</font>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	<div id="about"><font style="font-weight:bold">相关推荐:<br></font>
		<ul >
			<c:forEach var="essay" items="${aboutEssays }">
			<li v-for="essay in aboutEssays" style="margin-top:10px;font-size:14px">
				<a href="http://localhost:8080/MyOil/getEssay?id=${essay.id}">${essay.title}</a><br/></li>
			</c:forEach>
		</ul>
	</div>
</div>

<div id="others">
	<div>
		<img alt="图片丢失" src="./static/img/oil.jpg">
	</div>
	<br>
	<font size="4" color="red">
		<span class="glyphicon glyphicon-fire"></span>&nbsp 本周热门
	</font>
	<div id="weekHots">
		<table class="table" id="weekHotsTable">
		  <tbody>
		  <c:forEach var="x" begin="1" end="9" step="1">
		     <tr v-for="i in 10">
		        <td><img width="20px" src="http://localhost:8080/MyOil/static/img/qq.jpg"/></td>  
		        <td>测试内容</td>  
		     </tr>
		  </c:forEach>
		  </tbody>
		</table>
	
	</div>
</div>
<%@include file="floor.html" %>
</body>
</html>