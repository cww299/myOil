<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>

<link href="./static/css/index.css" rel="stylesheet">
		

<title>加油站管理</title>
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">
<style type="text/css">
 div.item img{
    width:100%;
   }
  div#carousel-example-generic{
    width:100%;
    margin:0 auto;
  }
  

</style>
</head>

<body>
<%@include file="./header.jsp" %>
<center id="allContent">
	 <div id="firstModel">
		<table id="hotNews" class="table table-hover">
		  <caption>
		    <font color="Red"><span class="glyphicon glyphicon-fire">热点新闻</span></font>
		  </caption>
		  <c:forEach var="essay" items="${ newsEssays }">
		  <tr>
		  	<td><a href="http://localhost:8080/MyOil/getEssay?id=${essay.id}">${essay.title}</a></td>
		  	<td>${essay.views}</td>
		  </tr>
		  </c:forEach>
		</table>
		
		<div id="userInfo" style="background-color:#E0E0E0">
		
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			         石油财经
			        </a>
			      </h4>
			    </div>
			    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
			      <div class="panel-body">
			       	包含了丰富的石油财经最新信息，帮您了解最新的石油经济的发展
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingTwo">
			      <h4 class="panel-title">
			        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          设备技术
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
			      <div class="panel-body">
					我们有最新最强大的科技技术
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingThree">
			      <h4 class="panel-title">
			        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			          决策系统
			        </a>
			      </h4>
			    </div>
			    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
			      <div class="panel-body">
			       帮你做出一个完美的选择
			      </div>
			    </div>
			  </div>
			</div>
		
		</div>
		
		<div id="showMore">
			<ul class="nav nav-tabs" id="">    
				<li class="active"><a href="#tab_index" data-toggle="tab">首页</a></li>    
				<li><a href="#tab_user" data-toggle="tab">用户管理</a></li>    
				<li><a href="#tab_page" data-toggle="tab">文章管理</a></li> 
				<li><a href="#tab_hot" data-toggle="tab">热点管理</a></li> 
			</ul>
		</div>
		<div class="tab-content" id="showMorePane">    
			<div class="tab-pane in active" id="tab_index">      
				
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2200">
				  <!-- Indicators -->
				  <ol class="carousel-indicators">
				    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
				    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
				  </ol>
				  <div class="carousel-inner" role="listbox">
				    <div class="item active">
				      <img src="./static/img/2.jpg" >
				    </div>
				    <div class="item">
				            <img src="./static/img/1.jpg" >
				    </div>
				    <div class="item">
				            <img src="./static/img/2.jpg" >
				    </div>
				    <div class="item">
				            <img src="./static/img/4.jpg" >
				    </div>
				  </div>
				 
				  <!-- Controls -->
				  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
				    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				 
				  </a>
				  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
				    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				 
				  </a>
				 
				</div>
			</div>    
			<div class="tab-pane" id="tab_user"> 
				
			</div>    
			<div class="tab-pane" id="tab_page">      
				<p>What up girl, this is Section 2.</p>    
			</div>  
			<div class="tab-pane" id="tab_hot">      
				<p>What up girl, this is Section 3.</p>    
			</div> 
		</div>
	</div>
		
	<div>
		<img src="./static/img/1200x70-1.jpg">
	</div>
	<div class="smallBlock"></div>
	
	<div class="panel panel-info" id="oilEconomics">
	  <div class="panel-heading">
	  	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=economics">石油财经</a>
	  </div>
	  <div class="panel-body">
	    <table class="table">
		  <thead>
	  		 <th></th>
		     <th>推荐文章</th>
		     <th>最新消息</th>
		  </thead>
		  <tbody>
			  <tr>
			  	<td rowspan="15" width="300" ><img src="./static/img/econimics/economics-1.jpg"> </td>
			  </tr>
			  <tr>
			  	<td></td>
			  	<td rowspan="15">
			  		<div style="margin-left:35px"><img src="./static/img/oil1.jpg" width="300"></div>
			  		<div>
			  			<ul>
			  				<c:forEach var="essay" items="${ economicsTime }">
			  				<li style="margin-top:12px">
			  					<a href="http://localhost:8080/MyOil/getEssay?id=${essay.id}">${essay.title}</a>
			  					<span style="float:right;">
			  						<fmt:formatDate value='${essay.time}' pattern='MM-dd'/></span>
			  				</li>
			  				</c:forEach>
			  			</ul>
			  		</div>
			  	</td>
			  </tr>
			  <c:forEach var="essay" items="${ economicsEssays }">
			     <tr>
			        <td width="600">
			        <a href="http://localhost:8080/MyOil/getEssay?id=${ essay.id}">${essay.title}</a></td>  
			     </tr>
		     </c:forEach>
		  </tbody>
		</table>
	  </div>
	</div>
	
	<div><img src="./static/img/1200x70-2.jpg"> </div>
	
	<div class="smallBlock"></div>
	<div class="panel panel-success" id="technology">
	  <div class="panel-heading">
	  	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=technology">设备技术</a>
	  </div>
	  <div class="panel-body">
	  	<table class="table">
		  <thead>
	  		 <th></th>
		     <th>推荐文章</th>
		     <th>最新消息</th>
		  </thead>
		  <tbody>
			  <tr>
			  	<td rowspan="15" width="300" ><img src="./static/img/technology/techonology-1.jpg"> </td>
			  </tr>
			  <tr>
			  	<td></td>
			  	<td rowspan="15">
			  		<div style="margin-left:35px"><img src="./static/img/oil1.jpg" width="300"></div>
			  		<div>
			  			<ul>
			  			<c:forEach var="essay" items="${ technologyTime }">
			  				<li style="margin-top:12px">
			  					<a href="http://localhost:8080/MyOil/getEssay?id=${ essay.id}">${essay.title}</a>
			  					<span style="float:right;">
			  						<fmt:formatDate value='${essay.time}' pattern='MM-dd'/></span>
			  				</li>
			  			</c:forEach>
			  			</ul>
			  		</div>
			  	</td>
			  </tr>
			  <c:forEach var="essay" items="${ technologyEssays }">
			     <tr> 
			        <td style="width:520px;">
			        <a href="http://localhost:8080/MyOil/getEssay?id=${essay.id}">${essay.title}</a></td>  
			     </tr>
		     </c:forEach>
		  </tbody>
		</table>
	  </div>
	</div>
	
	<div class="panel panel-success" id="decisionSystem">
	  <div class="panel-heading">
	  	<a href="http://localhost:8080/MyOil/getEssayListByCategory?category=decision">决策系统</a>
	  </div>
	  <div class="panel-body">
	  	<table class="table">
		  <thead>
	  		 <th></th>
		     <th>推荐文章</th>
		     <th>最新消息</th>
		  </thead>
		  <tbody>
			  <tr>
			  	<td rowspan="15" width="300" ><img src="./static/img/decision/decision-1.jpg"> </td>
			  </tr>
			  <tr>
			  	<td></td>
			  	<td rowspan="15">
			  		<div style="margin-left:35px"><img src="./static/img/oil1.jpg" width="300"></div>
			  		<div>
			  			<ul>
			  			<c:forEach var="essay" items="${ decisionTime }">
			  				<li style="margin-top:12px">
			  					<a href="http://localhost:8080/MyOil/getEssay?id=${essay.id }">${essay.title}</a>
			  					<span style="float:right;">
			  						<fmt:formatDate value='${essay.time}' pattern='MM-dd'/></span>
			  				</li>
			  			</c:forEach>
			  			</ul>
			  		</div>
			  	</td>
			  </tr>
			  <c:forEach var="essay" items="${decisionEssays }">
			     <tr v-for="essay in decisionEssays" > 
			        <td style="width:520px;"><a href="http://localhost:8080/MyOil/getEssay?id=${ essay.id}">${essay.title}</a></td>  
			     </tr> 
			  </c:forEach>
		  </tbody>
		</table>
	  </div>
	</div> 
</center>
<%@include file="floor.html" %>
</body>
<script>

</script>
</html>