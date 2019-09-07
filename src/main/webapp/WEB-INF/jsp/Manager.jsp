<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>

</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>
<style>
#categorys{
	width:60%;margin:0 auto;
}
#categoryTable{
	width:100%;text-align:center;padding:0;
}
#inputCategory{
	width:70%;float:left;margin-bottom:5px;
}
#addCategory{
	width:40%;margin:0 auto;text-align:center;margin-top:20px;
}
#products{
	width:80%;margin:0 auto;text-align:center;display:none;
}
#products .nav{
	width:100%;float:left;margin-top:5px;text-align:left;
}
#updateUser{
	width:80%;margin:0 auto;display:none;
}
</style>

<title>后台管理</title>
</head>

<body>
<div class="User_state">
	<a href="http://localhost:8080/MyOil/user">
	<span class="glyphicon glyphicon-arrow-left"></span>返回</a>
	当前用户：${user.username}  用户名：${user.name }
</div>


<div class="tabbable">  
	<ul class="nav nav-tabs">    
		<li class="active"><a href="#tab_index" data-toggle="tab">首页</a></li>    
		<li><a href="#tab_user" data-toggle="tab">用户管理</a></li>    
		<li><a href="#tab_essay" data-toggle="tab">文章管理</a></li> 
		<li><a href="#tab_shopOnline" data-toggle="tab">网上便利店管理</a></li> 
	</ul>
	<div class="tab-content">    
		<div class="tab-pane in active" id="tab_index">      
			<div class="jumbotron">
  				<div class="container" align="center">
			      <h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">后台管理系统</h2>
			      <br>
			      <div class="text-muted">与世界分享你的逼格</div>
			      <br>
			      <br>
			      <p><a role="button" href="#" class="btn btn-success">注册</a></p>
			    </div>
			</div>
		</div>    
		<div class="tab-pane" id="tab_user"> 
			<div id="userList">
				<div class="input-group">
			      <input type="text" class="form-control" v-model="searchText" aria-label="...">
			      <div class="input-group-btn">
			        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">搜索<span class="caret"></span></button>
			        <ul class="dropdown-menu dropdown-menu-right" role="menu">
			          <li><a href="#" v-on:click="setParam('&username='+searchText)">查找用户名</a></li>
			          <li><a href="#" v-on:click="setParam('&id='+searchText)">查找用户ID</a></li>
			          <li><a href="#" v-on:click="setParam('&name='+searchText)">查找姓名</a></li>
			          <li class="divider"></li>
			          <li><a href="#" v-on:click="showUser">全部用户</a></li>
			        </ul>
				  </div>
				</div>
				<center>
				 <table class="table table-striped table-bordered table-hover  table-condensed"  style="width:80%;" v-if="!findResult">
				  <thead>
				     <th>ID</th><th>用户名</th><th>密码</th><th>姓名</th><th>联系方式</th><th>余额</th><th>权限</th><th></th><th></th></thead>
				  <tbody>
				     <tr v-for="user in users">
				       <td>{{user.id}}</td>
				       <td>{{user.username}}</td>
				       <td>{{user.password}}</td>
				       <td>{{user.name}}</td>
				       <td>{{user.phone}}</td>
				       <td>{{user.balance}}</td>
				       <td>{{user.power}}</td>
				       <td><a href="#" v-on:click="editUser(user)"><span class="glyphicon glyphicon-edit"></span> 编辑</a></td>
				       <td><a href="#" v-on:click="deleteUser(user.id)"><span class="glyphicon glyphicon-trash"></span> 删除</a></td>
				   </tr>
				  </tbody>
				</table> 
				<nav v-if="!findResult">
					<ul class="pagination">
						<li >
							<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
							<span v-else>
								<a href="#" v-on:click="turnPage(nowPage-1)">上一页</a></span>
						</li>
						<li v-for="i in pageNum">
							<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
							<span v-else>
								<a href="#" v-on:click="turnPage(i)">{{i}}</a></span> 
						</li>
						<li>
							<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
							<span v-else>
								  <a href="#" v-on:click="turnPage(nowPage-1+2)">下一页</a></span>
							<div class="resultNums">共：{{resultNum}}条记录</div>
						</li>
					 </ul>
				</nav> 
				
				<div class="alert alert-warning" role="alert" v-if="findResult">没有找到用户：{{this.searchText}}，请确认是否输入有误！</div>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"> 添加新用户</button>
				</center>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog">
        			<div class="modal-content">
			          <div class="modal-header">
			            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
			            <h4 class="modal-title">添加新用户</h4>
			          </div>
			          <div class="modal-body">
			            <p>用户信息</p>
			            用户名：<input type="text" class="form-control" v-model="username">
			            密码：<input type="text" class="form-control" v-model="password">
			            姓名：<input type="text" class="form-control" v-model="name">
			            联系方式：<input type="text" class="form-control" v-model="phone">
			            余额：<input type="text" class="form-control" v-model="balance">
			            权限：<select class="form-control" v-model="power">
								   <option value="1">1(普通用户权限)</option>
								   <option value="2">2(管理员权限)</option>
							</select>
			          </div>
			          <div class="modal-footer">
			            <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
			            <button class="btn btn-primary" type="button" v-on:click="addUser">添加</button>
         			 </div>
       			   </div>
               </div>
			</div>
			</div>
			
			<div id="updateUser">
				<div class="nav">
					<ol class="breadcrumb">
					  <li><a href="#" v-on:click="showUser">用户管理</a></li>
					  <li class="active">用户：{{user.username}}</li>
					</ol>
				</div>
				<div class="panel panel-success" style="width:50%;margin:0 auto;">
					  <div class="panel-heading">修改用户信息</div>
					  <div class="panel-body">
					  	<form id="updateUserForm">
					  	<input type="hidden" v-bind:value="user.id" name="id">
					  	<table class="table"  style="text-align:right;">
							<tr><td>用户名：</td>
								<td><input type="text" class="form-control" v-bind:value="user.username" name="username"></td></tr>
					        <tr><td>密码：</td>
					        	<td><input type="text" class="form-control" v-bind:value="user.password" name="password"></td></tr>
					        <tr><td>姓名：</td>
					        	<td><input type="text" class="form-control" v-bind:value="user.name" name="name"></td></tr>
					        <tr><td>联系方式：</td>
					        	<td><input type="text" class="form-control" v-bind:value="user.phone" name="phone"></td></tr>
					        <tr><td>余额：</td>
					        	<td><input type="text" class="form-control" v-bind:value="user.balance" name="balance"></td></tr>
					        <tr><td>权限：</td>
					         	<td><select class="form-control" v-bind:value="user.power" name="power">
										   <option value="1">1(普通用户权限)</option>
										   <option value="2">2(管理员权限)</option>
									</select></td></tr>
						</table>
						</form>
						<div style="text-align:center;">
							<button class="btn btn-primary" v-on:click="showUser">返回</button>
							<button class="btn btn-primary" v-on:click="isUpdateUser">修改</button>
						</div>
					  </div>
				</div>
			</div>
		</div>    
			
		<div class="tab-pane" id="tab_essay">    
		<center> 
			<div class="input-group">
		      <input type="text" class="form-control" v-model="searchText" aria-label="...">
		      <div class="input-group-btn">
		        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">搜索<span class="caret"></span></button>
		        <ul class="dropdown-menu dropdown-menu-right" role="menu">
		          <li><a href="#" v-on:click="findEssayBySomeData('title')">查找文章名</a></li>
		          <li><a href="#" v-on:click="findEssayBySomeData('authorId')">查找作者</a></li>
		          <li><a href="#" v-on:click="findEssayBySomeData('id')">查找文章ID</a></li>
		          <li class="divider"></li>
		          <li><a href="#" v-on:click="showEssay">全部文章</a></li>
		        </ul>
			  </div>
			</div>
			<div class="alert alert-danger" role="alert" v-if='isShowAlert'>{{ showMessage }}</div>
			 <table class="table table-striped table-bordered table-hover  table-condensed"  style="width:80%;">
			  <thead>
			     <th>ID</th><th>文章名</th><th>浏览次数</th><th>发布时间</th><th>作者</th><th>分类</th><th>是否推荐</th><th></th></thead>
			  <tbody>
			     <tr v-for="essay in essays">
			       <td>{{essay.id}}</td>
			       <td>{{essay.title}}</td>
			       <td>{{essay.views}}</td>
			       <td>{{essay.time}}</td>
			       <td>{{essay.authorId}}</td>
			       <td>{{essay.category}}</td>
			       <td>{{essay.isHot}}</td>
			       <td><a href="#" v-on:click="deleteEssay(essay.id)"><span class="glyphicon glyphicon-trash"></span> 删除</a></td>
			   </tr>
			  </tbody>
			</table> 	
			
			<!-- <nav>
			  <ul class="pagination">
			    <li >
				 	<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
					<span v-else>
					    <a href="#" >上一页</a></span>
				 </li>
				 <li v-for="i in pageNum">
					<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
					<span v-else>
						<a href="#" >{{i}}</a></span> 
				</li>
				<li>
					<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
					<span v-else>
					    <a href="#" >下一页</a></span>
				<div class="resultNums">共：条记录</div>
				</li>
			  </ul>
			</nav>  -->
		</center>
		</div>  
					
		<div class="tab-pane" id="tab_shopOnline">    
		 
			<div id="categorys">
				<table id="categoryTable" class="table table-striped table-bordered table-hover  table-condensed" >
				  <thead>
				     <th>ID</th><th>分类名</th><th>商品管理</th><th>编辑</th><th>删除</th></thead>
				  <tbody>
				     <tr v-for="category in categoryList">
				     	<td>{{category.id}}</td>
				     	<td>{{category.name}}</td>
				     	<td><a href="#" v-on:click="productManager(category.name)"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>
				     	<td><a href="#" v-on:click="updateCategory(category.id)"><span class="glyphicon glyphicon-edit"></span></a></td>
				     	<td><a href="#" v-on:click="deleteCategory(category.id)"><span class="glyphicon glyphicon-trash"></span></a></td>
				     </tr>
				  </tbody>
				</table> 	
				<div id="addCategory">
					<div class="panel panel-success">
					  <div class="panel-heading">添加分类</div>
					  <div class="panel-body">
							  <label style="float:left;margin:15px 5px 5px 20px;">分类名：</label>
							  <input type="text" class="form-control" id="inputCategory">
							  <button class="btn btn-primary" v-on:click="addCategory">添加</button>
					  </div>
					</div>
				</div>
			</div>
			<div id="products">
				<div class="nav">
					<ol class="breadcrumb">
					  <li><a href="#" v-on:click="categoryManager">分类管理</a></li>
					  <li v-if="nowLocation=='商品管理'" class="active">{{thisCategory}}</li>
					  <li v-else-if="nowLocation=='修改商品'"><a href="#" v-on:click="productManager(thisCategory)">{{thisCategory}}</a></li>
					  <li v-if="nowLocation=='修改商品'" class="active">{{product.name}}</li>
					</ol>
				</div>
				<div id="productList">
					<table class="table table-striped table-bordered table-hover  table-condensed">
					  <thead>
					     <th>ID</th><th>商品名</th><th>分类</th><th>图片</th><th>价格</th><th>库存</th><th>月销售</th><th>商品说明</th><th>编辑</th><th>删除</th></thead>
					  <tbody>
					     <tr v-for="product in productList">
					     	<td>{{product.id}}</td>
					     	<td>{{product.name}}</td>
					     	<td>{{product.category}}</td>
					     	<td><img :src="product.img" style="width:40px;height:40px;"></td>
					     	<td>{{product.price}}</td>
					     	<td>{{product.stock}}</td>
					     	<td>{{product.sales}}</td>
					     	<td>{{product.description}}</td>
					     	<td><a href="#" v-on:click="updateProduct(product.id)"><span class="glyphicon glyphicon-edit"></span></a></td>
				     		<td><a href="#" v-on:click="deleteProduct(product.id)"><span class="glyphicon glyphicon-trash"></span></a></td>
					     </tr>
					  </tbody>
					</table>
					<nav>
					  <ul class="pagination">
					    <li >
						 	<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
							<span v-else>
							    <a href="#" v-on:click="turnPage(nowPage-1)">上一页</a></span>
						 </li>
						 <li v-for="i in pageNum">
							<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
							<span v-else>
								<a href="#" v-on:click="turnPage(i)">{{i}}</a> </span> 
						</li>
						<li>
							<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
							<span v-else>
							    <a href="#" v-on:click="turnPage(nowPage-1+2)">下一页</a></span>
						<div class="resultNums">共：{{nums}}条记录</div>
						</li>
					  </ul>
					</nav> 
					
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProduct"> 添加新商品</button>
				
					<div class="modal fade" id="addProduct" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
						<div class="modal-dialog">
		        			<div class="modal-content">
					          <div class="modal-header">
					            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
					            <h4 class="modal-title">添加新商品</h4>
					          </div>
					          <div class="modal-body">
					          <form id="myform" enctype="multipart/form-data;charset=utf-8">
					          <table style="margin:0 auto;width:80%;">
					          	<tr><td><label>商品名：</label></td>
						            <td><input type="text" class="form-control" id="pname" name="name"></td></tr>
						        <tr><td><label>商品分类：</label></td>
						        	<td><select class="form-control" name="category" v-bind:value="thisCategory">
											   <option v-for="category in categoryList" v-bind:value="category.name" >{{category.name}}</option>
										</select></td></tr>
						        <tr><td><label>图片：</label></td>
						        	<td height="30px"><input type="file" name="file"></td></tr>
						        <tr><td><label>价格：</label></td>
						        	<td><input type="number" class="form-control" name="price" value="0"></td></tr>
						        <tr><td><label>库存：</label>
						       		</td><td><input type="number" class="form-control" name="stock"  value="0"></td></tr>
						        <tr><td><label>月销售：</label></td>
						        	<td><input type="number" class="form-control" name="sales"  value="0"></td></tr>
						        <tr><td><label>商品说明：</label></td>
						        	<td><input type="text" class="form-control" name="description"  value="no"></td></tr>
					          </table>
					          </form>
					          </div>
					          <div class="modal-footer">
					            <button data-dismiss="modal" class="btn btn-default" type="button">取消</button>
					            <button class="btn btn-primary" type="button" v-on:click="addProduct">添加</button>
		         			 </div>
		       			   </div>
		               </div>
					</div>
				</div>
				<div id="updateProduct">
					<form id="updateProductForm">
					<table style="margin:0 auto;width:50%;">
						<tr><td><label>商品名：</label></td>
							<td><input type="text" class="form-control" name="name" v-bind:value="product.name"></td></tr>
						<tr><td><label>商品分类：</label></td>
							<td><select class="form-control" name="category" v-bind:value="product.category">
									<option v-for="category in categoryList" v-bind:value="category.name" >{{category.name}}</option>
								</select></td></tr>
						<tr><td><label>图片：</label></td>
							<td style="text-align:left;"><img :src="product.img" height="150px">
														<input type="file" value="isnull" name="file"></td></tr>
						<tr><td><label>价格：</label></td>
							<td><input type="text" class="form-control" name="price" v-bind:value="product.price"></td></tr>
						<tr><td><label>库存：</label>
							</td><td><input type="text" class="form-control" name="stock"  v-bind:value="product.stock"></td></tr>
						<tr><td><label>月销售：</label></td>
							<td><input type="text" class="form-control" name="sales"  v-bind:value="product.sales"></td></tr>
						<tr><td><label>商品说明：</label></td>
							<td><input type="text" class="form-control" name="description"  v-bind:value="product.description"></td></tr>
					 </table>
					 <input type="hidden" v-bind:value="product.id" name="id">
					 </form>
					 <button class="btn btn-primary" v-on:click="isUpdateProduct">修改</button>
				</div>
			</div>
			
		
		</div>
		
	</div>
</div>


<script>
new Vue({					//文章管理
	el:"#tab_essay",
	data:{
		essays:'',
		findResult:false,
		searchText:'',
		essayTitle:'',
		id:'',
		authorId:'',
		nowPage:1,
		pageNum:1,
		isShowAlert:false,
		showMessage:'',
	},
	methods:{
		showEssay:function(){
			url="http://localhost:8080/MyOil/getEssayList?num=999";
			self=this;
			axios.get(url).then(function(response){
				self.essays=response.data;
			});
		}, 
		findEssayBySomeData:function(type){
			self=this;
			if(self.searchText==''){
				self.isShowAlert=true;
				self.showMessage='搜索信息不能为空！';
				return;
			}
			self.isShowAlert=false;
			url="http://localhost:8080/MyOil/getEssayBySomeData?"+type+"="+this.searchText;
			axios.get(url).then(function(response){
				if(response.data==''){
					self.isShowAlert=true;
					self.showMessage='查找不到该信息！';
				}
				self.essays=response.data;
			})
		},
		editEssay:function(id){
			alert(id);
		},
		deleteEssay:function(id){
			if(confirm('是否确认删除？')){
				self=this;
				url="http://localhost:8080/MyOil/deleteEssay?id="+id;
				axios.get(url).then(function(response){
					if(response.data>0){
						alert('删除成功');
						for(var i=0;i<self.essays.length;i++){
							if(self.essays[i].id==id){
								self.essays.splice(i,1);
								return;
							}
						}
					}
				})
			}
		},
		addEssay:function(){
		}
	}
})
new Vue({			//用户管理
	el:"#tab_user",
	data:{
		users:[],
		user:'',
		findResult:false,
		searchText:'',
		username:'',
		password:'',
		name:'',
		phone:'',
		balance:0,
		power:1,
		nowPage:1,
		pageNum:1,
		resultNum:0,
		showUserParam:''
	},
	methods:{
		setParam:function(param){ 
			this.showUserParam=param;
			this.$options.methods.getUsers(param,this); 
		},
		getUsers:function(param,self){
			url="http://localhost:8080/MyOil/getUsers?"+param;
			axios.get(url).then(function(response){
				if(response.data==null||response.data=="")
					self.findResult=true;
				else{
					self.users=response.data;
					self.findResult=false;	
				}
			})
			axios.get("http://localhost:8080/MyOil/getResultNum?"+param).then(function(response){
					self.resultNum=Number(response.data).toFixed(0);
					self.pageNum=parseInt(self.resultNum/10+1);
			})
			
		},
		turnPage:function(page){
			this.nowPage=page;
			this.$options.methods.getUsers(this.showUserParam+"&nowPage="+page,this);
		},
		showUser:function(){
			document.getElementById("userList").style.display="block";
			document.getElementById("updateUser").style.display="none";
			this.showUserParam="";
			this.$options.methods.getUsers(this.showUserParam,this);
		}, 
		editUser:function(user){
			this.user=user;
			document.getElementById("userList").style.display="none";
			document.getElementById("updateUser").style.display="table";
		},
		isUpdateUser:function(){
			if(confirm("是否确认修改？")==true){
				let param=new FormData(document.getElementById("updateUserForm"));
				if(param.get("username")==null || param.get("username")==""){
					alert("用户名不能为空！");
					return;
				}
				if(param.get("password")==null || param.get("password")==""){
					alert("密码不能为空！");
					return;
				}
				url="http://localhost:8080/MyOil/updateUser";
				axios.post(url,param).then(function(response){
					if(response.data=="success"){
						alert("修改成功");
					}
					else
						alert("修改失败");
				})  
			}
			return false;
		},
		deleteUser:function(id){
			self=this;
			if(confirm("是否确认删除？")==true){
				url="http://localhost:8080/MyOil/deleteUser?id="+id;
				axios.get(url).then(function(response){
					if(response.data=="success"){
						alert("删除成功！");
						self.$options.methods.getUsers(self.showUserParam,self);
					}
					else
						alert("删除失败");
				})
			}
		},
		addUser:function(){
			self=this;
			var url="http://localhost:8080/MyOil/addUser?username="+this.username+"&password="+this.password+
					"&name="+this.name+"&phone="+this.phone+"&balance="+this.balance+"&power="+this.power;				 
			axios.get(url).then(function(response){
				if(response.data=="success"){
					alert("添加成功");
					self.$options.methods.getUsers(self.showUserParam,self);
				}
				else if(response.data=="fail")
					alert("该用户名已存在");
				else
					alert("添加失败");
			})
		    $("#myModal").modal('hide');
		},
		checkSearch:function(){
			if(this.searchText==null||this.searchText==""){
				alert("请输入正确参数");
				return false;
			}
			return true;
		}
	}
})
	
new Vue({	//网上便利店
	el:"#tab_shopOnline",
	data:{
		categoryList:[],	//展示分类页表
		productList:[],		//当前展示商品列表
		nowPage:1,			//当前分页
		pageNum:5,			//分页页数
		nums:0,				//当前所查分类记录数目
		thisCategory:'',	//当前所查看的分类类型
		nowLocation:'商品管理',      //设置导航栏当前位置
		product:''         //当前修改商品
	},
	methods:{
		categoryManager:function(){     //分类管理
			document.getElementById("categorys").style.display="table";
			document.getElementById("products").style.display="none";
		},
		addCategory:function(){		//增加分类
			self=this;
			var category=document.getElementById("inputCategory").value;
			if(category==null||category==""){
				alert("类名不能为空");
				return;
			}
			url="http://localhost:8080/MyOil/addCategory?name="+category;
			axios.get(url).then(function(response){
				if(response.data=="success"){
					alert("添加成功！");
					self.$options.methods.getCategoryList(self);
				}
				else
					alert("添加失败！");
			})
		},
		deleteCategory:function(id){	//删除分类
			self=this;
			if(confirm("是否确认删除！")==false)
				return;
			url="http://localhost:8080/MyOil/deleteCategory?id="+id;
			axios.get(url).then(function(response){
				if(response.data=="success"){
					alert("删除成功！");
					self.$options.methods.getCategoryList(self);
				}
				else
					alert("删除失败！"); 
			})
		},
		updateCategory:function(id){	//修改分类
			//product表中category使用的是category的名字，并不是唯一主键，因此改变分类名称会发生错误
			self=this;
			var name=prompt("修改分类名为:");
			if(name==null||name==""){
				alert("分类名称不能为空！");
				return;
			}
			url="http://localhost:8080/MyOil/updateCategory?id="+id+"&name="+name;
			axios.get(url).then(function(response){
				if(response.data=="success"){
					alert("修改成功！");
					self.$options.methods.getCategoryList(self);
				}
			})
		},
		getCategoryList:function(self){		//获取分类列表
			url="http://localhost:8080/MyOil/getCategory";
			axios.get(url).then(function(response){
				self.categoryList=response.data;
			})
		},
		productManager:function(name){ 		//分类商品管理
			//进行分类的商品管理
			self=this;
			self.thisCategory=name;
			self.nowLocation='商品管理';
			self.nowPage=1;
			url="http://localhost:8080/MyOil/getProducts?category="+name;
			axios.get(url).then(function(response){
				self.productList=response.data;
			})
			url="http://localhost:8080/MyOil/getResultNums?category="+name;
			axios.get(url).then(function(response){
				self.nums=Number(response.data).toFixed(0);
				self.pageNum=parseInt(self.nums/12+1);
			})
			document.getElementById("categorys").style.display="none";
			document.getElementById("products").style.display="table";
			document.getElementById("productList").style.display="block";
			document.getElementById("updateProduct").style.display="none";
		},
		addProduct:function(){		//增加商品
			//添加新商品并上传	
			//get方法获取formdata对象的值获取失败  原因：浏览器版本问题s
			//console.log(param.get('name'));
			let param = new FormData(document.getElementById("myform"));
			if(param.get("file").name==null||param.get("file").name==""){
				alert("请选择图片");return;
			}
			var config = {										
				headers: {'Content-Type': 'multipart/form-data;charset=utf-8'}
        	}
			console.log(param.get("price"));
			url="http://localhost:8080/MyOil/addProduct";
			axios.post(url,param).then(function(response){
				if(response.data=="success"){
					alert("添加成功");
				}
				else
					alert("添加失败");
			}) 
			$("#addProduct").modal('hide');
			this.$options.methods.getProduct(this);
		},
		updateProduct:function(id){		//修改商品
			self=this;
			self.nowLocation='修改商品';
			document.getElementById("productList").style.display="none";
			document.getElementById("updateProduct").style.display="block";
			url="http://localhost:8080/MyOil/getProducts?id="+id;
			axios.get(url).then(function(response){
				self.product=response.data[0];
			})
		},
		isUpdateProduct:function(){  //确认修改
			self=this;
			if(confirm("是否确认修改？")==true){
				let param=new FormData(document.getElementById("updateProductForm"));
				url="http://localhost:8080/MyOil/updateProduct";
				axios.post(url,param).then(function(response){
					if(response.data=="success"){
						alert("修改成功");
					}
					else
						alert("修改失败");
					}) 
				this.$options.methods.updateProduct(self.product.id);
			}
		},
		deleteProduct:function(id){		//删除商品
			self=this;
			url="http://localhost:8080/MyOil/deleteProduct?id="+id;
			if(confirm("是否确认删除！")==true){
				axios.get(url).then(function(response){
					if(response.data=="success"){
						alert("删除成功！");
						self.$options.methods.getProduct(self);
					}
					else
						alert("删除失败");
				})	
			}
		},
		getProduct:function(self){		//根据当前所查分类和当前页数查询商品
			url="http://localhost:8080/MyOil/getProducts?category="+self.thisCategory+"&nowPage="+self.nowPage+"&r="+Math.random()*100;
			axios.get(url).then(function(response){
				self.productList=response.data;
			})
			url="http://localhost:8080/MyOil/getResultNums?category="+self.thisCategory+"&r="+Math.random()*80;
			axios.get(url).then(function(response){
				self.nums=Number(response.data).toFixed(0);
				self.pageNum=parseInt(self.nums/12+1);
			})
		},
		turnPage:function(page){	//页面跳转
			this.nowPage=page;
			this.$options.methods.getProduct(this);
		}
	},
	mounted:function(){
		this.$options.methods.getCategoryList(this);
	}
})	
</script>

</body>
</html>