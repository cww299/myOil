<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>加油站管理-网上便利店</title>
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">


<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>
 <style>
#accordion{
	width:15%;
	text-align:center;
	float:left;
}
#switchNav,#switchNavPane{
	width:80%;
	margin:0 auto;
	margin-top:5px;
}
#productContent{
	width:84%;
	margin-left:1%;
	
	float:right;
	//background-color:#FFCC66;
}
.product{
	width:24%;
	height:365px;
	margin:4px;
	border:1px solid gray;
	float:left;
}
.product:hover{
  border:2px solid red;
   
}
.name{
	font-size:20px;font-weight:bold;
}
.description{
	color:gray;margin-top:5px;
}
.sales{
	color:gray;float:left;width:50%;
}
.cart{
	float:right;
	width:15%;
	text-align:right;
}
.cart button.shoppingCart{
	border-radius:20px;
	border:none;
	outline:none;
	width:40px;
	height:40px;
	background-color:#D00000;
	font-size:20px;
	color:white;
}
.cart .shoppingNum{
	
}
.price{
	color:red;
	font-size:18px;
	margin-top:1px;float:left;width:50%;
}
nav{
	//position:fixed;
	float:right;
	width:100%;
	
}
.modal-dialog{
	text-align:left;margin-top:200px;width:30%;
}
span{
	cursor: pointer;
}
 </style>
</head>
<body>
<%@include file="header.jsp" %>

<div id="switchNav">
	<ul class="nav nav-tabs">    
		<li class="active"><a href="#tab_product" data-toggle="tab">商品</a></li>    
		<li><a href="#tab_evaluate" data-toggle="tab">评价</a></li>    
		<li><a href="#tab_info" data-toggle="tab">详情</a></li> 
	</ul>
</div>
<div class="tab-content" id="switchNavPane">    
	<div class="tab-pane in active" id="tab_product"> 
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<c:forEach var="category" items="${categoryList }">
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading${category.id }">
				      <h4 class="panel-title">
				        <a role="button" data-toggle="collapse"  
				        	href="#collapse${category.id }" 
				        	data-parent="#accordion"
				        	aria-expanded="true" 
				        	class="collapsed" 
				        	v-on:click="selectCategory('${category.name }')"
				        	aria-controls="collapse${category.id }"
				        	>
				          ${category.name }
				        </a>
				      </h4>
				    </div>
				    <div id="collapse${category.id}" 
				    		class="panel-collapse collapse" role="tabpanel" 
				    		aria-labelledby="heading${category.id }">
				      <div class="panel-body">
				      <c:choose>
				      <c:when test="${fn:length(category.list)!=0 }">
					      <c:forEach var="product" items="${ category.list}">
					      	<a href="#">${product.name }</a><br/>
					      </c:forEach>
				      </c:when>
				      <c:otherwise>
				          暂无更多商品
				      </c:otherwise>
				      </c:choose>
				      </div>
				    </div>
				</div>
			</c:forEach>	 
		</div>
		
		<div id="productContent">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="请输入查找商品..." >
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button">搜索</button>
				      </span>
			</div>
			<div class="alert alert-info" role="alert" style="display:none;">信息提示</div>
			<div class="alert alert-warning" role="alert" style="display:none;">警告提示</div>
			<div v-for="product in showProducts" class="product"  v-on:onclick="c" >
				 <img width="100%" height="240" v-bind:src="product.img">
				<div style="margin:5px;width:90%;">
				<div class="name">{{product.name}}</div>
				<div class="description">{{product.description}}</div>
				<div class="sales">月销：{{product.sales }}</div>
				<div class="cart">
					<button type="button"  data-toggle="modal" data-target="#myModal" class="shoppingCart" v-on:click="cart(product.id,product.price,product.stock,product.name)">
						 <span class="glyphicon glyphicon-shopping-cart" ></span></button>
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  data-backdrop="static">
						<div class="modal-dialog">
			        		<div class="modal-content">
						    	<div class="modal-header">
						            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
						            <h4 class="modal-title"><font color="Red">{{productName}}</font></h4>
						        </div>
							    <div class="modal-body">
							    规格/口味选择：<br/>
							    	<div class="btn-group" data-toggle="buttons">
							    		<label class="btn btn-default active" id="defaultLabel" v-on:click="chooseTaste('default',price,stock,productName)">
										<input type="radio" checked value="default">默认
										</label>
										<label class="btn btn-default" v-for="taste in tastes" v-on:click="chooseTaste(taste.name,taste.price,taste.stock,productName)">
										<input type="radio" v-bind:value="taste.id">{{taste.name}}
										</label>
									</div><br>
								单价：￥{{price}}<br>
								库存：{{stock}}<br>
								<div style="margin-top:10px;">
									<label style="float:left;margin-top:10px;">数量：</label>
									<div style="margin-right:3px;float:left;margin-top:10px;">
										<span class="glyphicon glyphicon-minus-sign" v-on:click="decrease"></span></div>
									<div style="width:13%;float:left;"><input type="text" v-model.number="num" class="form-control" ><br></div>
									<div style="margin-left:3px;float:left;margin-top:10px;">	
										<span class="glyphicon glyphicon-plus-sign" v-on:click="increase"></span></div> 
								</div>
								<br><br>
								<br>价格：<font color="red">￥{{price*num}}</font>
							    </div>
							    <div class="modal-footer">
							    	 <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
			            			 <button class="btn btn-primary" type="button" v-on:click="addCart">添加购物车</button>
				         		</div>
			       			</div>
			             </div>
					</div>
				</div> 
				<div class="price">￥{{product.price }}</div>
				</div>
			</div>
			
					
			<nav>
				 <ul class="pagination">
				 <li >
				 	<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
					<span v-else>
					    <a href="#" v-on:click="pageTurn(nowPage-1)">上一页</a>
					</span>
				 </li>
				 <li v-for="i in pageNum">
					<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
					<span v-else>
						<a href="#" v-on:click="pageTurn(i)">{{i}}</a>
					</span> 
				</li>
				<li>
					<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
					<span v-else>
					    <a href="#" v-on:click="pageTurn(nowPage-1+2)">下一页</a>
					</span>
				<div class="resultNums">共：{{results}}条记录</div>
				</ul>
			</nav> 
		
		</div>
	</div>
		   
	<div class="tab-pane" id="tab_evaluate"> 
					
	</div>    
	<div class="tab-pane" id="tab_info">      
					<p>What up girl, this is Section 2.</p>    
	</div>  
</div>

		


<%@include file="floor.html" %>
</body>
<script>
new Vue({
	el: "#switchNavPane",
    data: {
        nowPage:1,     //当前页数
        pageNum:5,		//全部页数
        results:0,		//结果数目	
        searchText:'',		//搜索内容
        showProducts:[],	//展示商品
        productName:'',		//当前选择商品名称
        id:0,               //当前选择商品Id
        tastes:'',			//商品口味/规格
        taste:'default',			//当前选择的口味/规格
        price:0.0,			//当前规格价格
        num:0,				//购买数量
        stock:0,			//当前选择商品口味/规格库存
        url:'http://localhost:8080/MyOil/',
        urlParam:'?t=1'
    },
    methods: {
        c: function () {
           
        },
    	cart:function(id,price,stock,name){
    		//打开加入购物车界面时，进行的初始化
    		self=this;
    		self.id=id;
    		self.price=price;
    		self.stock=stock;
    		self.num=0;
    		self.productName=name;
    		self.taste="default";
    		//document.getElementById("defaultLabel").className="btn btn-default active";
    		document.getElementById("defaultLabel").click();
    		url="http://localhost:8080/MyOil/getTaste?pid="+id;
    		axios.get(url).then(function(response){
    			self.tastes=response.data;
    		})
    	},
    	pageTurn:function(page){
    		self=this;
    		url=self.url+'getProducts'+self.urlParam+'&nowPage='+page;
    		axios.get(url).then(function(response){
    			self.showProducts=response.data;
    			self.nowPage=page;
    		})
    	},
    	resultNums:function(self){ 
    		url=self.url+'getResultNums'+self.urlParam;
    		axios.get(url).then(function(response){
    			self.results=Number(response.data).toFixed(0);
    			self.pageNum=parseInt(self.results/12+1);
    		}) 
    	},
    	selectCategory:function(category){
    		self=this;
    		self.nowPage=1;
    		self.urlParam='?t=1&category='+category;  
    		url=self.url+'getProducts'+self.urlParam;
    		axios.get(url).then(function(response){
    			self.showProducts=response.data;
    			self.$options.methods.resultNums(self);
    		})
    	},
    	chooseTaste:function(taste,price,stock,pname){
    		console.log(taste+" "+price+" "+stock+" "+pname);
    		this.taste=taste;
    		this.price=price;
    		this.stock=stock;
    		this.productName=pname;
    	},
    	increase:function(){
    		this.num++;
    	},
    	decrease:function(){
    		if(this.num>0)
    			this.num--;
    	},
    	addCart:function(){
    		self=this;
    		if(self.num>self.stock){
    			alert("该商品库存不足！请联系客服人员或选择其他商品");
    			return;	
    		}
    		if(self.num<1){
    			alert("请选择商品数量");
    			return;
    		}
    		url="http://localhost:8080/MyOil/addCart?id="+self.id+"&productName="+self.productName
    			+"&num="+self.num+"&taste="+self.taste+"&price="+self.price;
    		axios.get(url).then(function(response){
    			if(response.data=="fail")
    				alert("请先登陆");
    			else{
    				alert("加入成功！");
    				 $("#myModal").modal('hide');
    			}
    		})
    	}
    },
    mounted:function(){
    	self=this;
		url="http://localhost:8080/MyOil/getProducts?nowPage=1";
		axios.get(url).then(function(response){
			self.showProducts=response.data;
		})
		this.$options.methods.resultNums(self);
    }
})


</script>

</html>