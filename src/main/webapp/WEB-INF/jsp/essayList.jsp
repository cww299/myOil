<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<link href="./static/css/essayList.css" rel="stylesheet">
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>加油站-石油浏览</title>

</head>
<%@include file="header.jsp"%>
<body>
<div id="breadcrumbNav">
	<ol class="breadcrumb">
	  <li><a href="http://localhost:8080/MyOil/index">首页</a></li>
	  <li class="active">
	  	<c:if test="${param.category == 'economics' }">
	  		石油财经
	  		<c:set var="aboutEssays" value="${economicsEssays }"/>		
	  	</c:if>
	  	<c:if test="${param.category =='technology'}">
	  		设备技术
	  		<c:set var="aboutEssays" value="${technologyEssays }"/>	
	  	</c:if>
	  	<c:if test="${param.category =='decision'}">
	  		决策系统
	  		<c:set var="aboutEssays" value="${decisionEssays }"/>	
	  	</c:if>
	  	<c:if test="${param.category =='news'}">
	  		新闻资讯
	  		<c:set var="aboutEssays" value="${newsEssays }"/>	
	  	</c:if>
	  </li>
	</ol>
</div>
<div id="essayList">
	<input type="hidden" id="category" value="${param.category }">
	<input type="hidden" id="nowPage" value="${param.nowPage }">
	<table class="table">
	    <tbody>
	    	<c:forEach var="essay" items="${essayList }">
	     	<tr>
				<td rowspan="2" height="50" width="100">
					<img width="220" src="./static/img/oil1.jpg"/></td>  
			    <td colspan="3">
			    	<a href="http://localhost:8080/MyOil/getEssay?id=${essay.id }">
			    	<h3>${essay.title }</h3></a></td>  
			</tr>
			<tr height="5">
				
			    <td>
			    	<span class="glyphicon glyphicon-time"></span>
			    	<font color="gray" >${essay.time }</font> </td> 
			    <td>			
			    	<span class="glyphicon glyphicon-eye-open"></span>
			    	<font color="gray" >${essay.views }</font></td>  
			    <td><span class="glyphicon glyphicon-link"></span>
			    	<font color="gray">分享：</font>
			    	<a href="#"><img width="23" src="./static/img/wechat.jpg"></a>
			    	<a href="#"><img width="23" src="./static/img/webo.jpg"></a>
			    	<a href="#"><img src="./static/img/qq.jpg"></a>
			    </td>  
			    
	     	</tr>
	     	</c:forEach>
	  	</tbody>
	</table>
	
	<nav>
		 <ul class="pagination">
		 <li >
		 	<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
			<span v-else>
			    <a :href="'./getEssayListByCategory?category='+category+'&nowPage='+(nowPage-1)">上一页</a>
			</span>
		 </li>
		 <li v-for="i in pageNum">
			<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
			<span v-else>
				<a :href="'./getEssayListByCategory?category='+category+'&nowPage='+i">{{i}}</a>
			</span> 
		</li>
		<li>
			<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
			<span v-else>
			    <a :href="'./getEssayListByCategory?category='+category+'&nowPage='+parseInt(nowPage-2+3)">下一页</a>
			</span>
		<div class="resultNums">共：{{nums}}条记录</div>
		</ul>
	</nav> 
</div>

<div id="others">
	<div id="weixin">
		<div class="weixinImg">
			<img  src="./static/img/jyweixin.jpg" >
		</div>
		<p><font size="5">中国油联 一路相随</font></p>
		<p><font size="3">扫码查看更多油站资讯</font></p> 
	</div>
	<div style="float:left;">
		<img src="./static/img/system/iconhot.jpg">
		<font size="4">&nbsp;推荐阅读</font>
	</div>
	<div id="about" style="float:left;">
		<table >
		<c:forEach var="essay" items="${aboutEssays }" varStatus="i" >
			<tr>
				<td><div class="number">${i.index+1 }</div></td>
				<td></td><td></td>
			</tr>
			<tr>
				<td></td>
				<td rowspan="2"><img width="150" height="95" src="./static/img/oil1.jpg">   </td>
				<td><a href="http://localhost:8080/MyOil/getEssay?id=${essay.id }">${essay.title}</a></td>
			</tr>
			<tr style="border-bottom:1px solid #E8E8E8">
				<td></td>
				<td><font color="gray">
						<span class="glyphicon glyphicon-eye-open"></span>${essay.views }次
					</font>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</div>

<%@include file="floor.html"%>
</body>
<script>
new Vue({
	el:"#essayList",
	data:{
		category:'',
		nums:0,
		pageNum:0,
		nowPage:1
	},
	method:{
		
	},
	mounted:function(){
		self=this;
		self.category=document.getElementById("category").value;
		if(document.getElementById("nowPage").value!="")
			self.nowPage=document.getElementById("nowPage").value;
	
		url="http://localhost:8080/MyOil/getNumOfCategory?category="+self.category;
		axios.get(url).then(function(response){ 
			self.nums=Number(response.data).toFixed(0);
			self.pageNum=parseInt(self.nums/10+1);
		}).catch(function(e){
			alert(e);
		});
	},
	methods:{
	}
	
}) 




</script>
</html>