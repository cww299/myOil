<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>

<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>


<title>后台管理</title>
</head>
<body>
<div class="User_state">
	当前用户：${user.username}  用户名：${user.name }
</div>


<div class="tabbable">  
	<ul class="nav nav-tabs">    
		<li class="active"><a href="#tab_index" data-toggle="tab">首页</a></li>    
		<li><a href="#tab_user" data-toggle="tab">用户管理</a></li>    
		<li><a href="#tab_essay" data-toggle="tab">文章管理</a></li> 
		<li><a href="#tab_hot" data-toggle="tab">页面管理</a></li> 
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
			
			<div class="input-group">
		      <input type="text" class="form-control" v-model="searchText" aria-label="...">
		      <div class="input-group-btn">
		        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">搜索<span class="caret"></span></button>
		        <ul class="dropdown-menu dropdown-menu-right" role="menu">
		          <li><a href="#" v-on:click="findUserByUsername">查找用户名</a></li>
		          <li><a href="#" v-on:click="findUserById">查找用户ID</a></li>
		          <li><a href="#" v-on:click="findUserByName">查找姓名</a></li>
		          <li class="divider"></li>
		          <li><a href="#" v-on:click="showUser">全部用户</a></li>
		        </ul>
			  </div>
			</div>
			
			<center>
			 <table class="table table-striped table-bordered table-hover  table-condensed"  style="width:1000px;">
			  <thead>
			     <th>ID</th>
			     <th>用户名</th>
			     <th>密码</th>
			     <th>姓名</th>
			     <th>联系方式</th>
			     <th>余额</th>
			     <th>权限</th>
			     <th></th>
			     <th></th>
			  </thead>
			  <tbody>
			     <tr v-for="user in users">
			       <td>{{user.id}}</td>
			       <td>{{user.username}}</td>
			       <td>{{user.password}}</td>
			       <td>{{user.name}}</td>
			       <td>{{user.phone}}</td>
			       <td>{{user.balance}}</td>
			       <td>{{user.power}}</td>
			       <td>
			       		<a href="#" v-on:click="editUser(user.id)">
   							 <span class="glyphicon glyphicon-edit"></span> 编辑
						</a>
			       </td>
			       <td>
			       		<a href="#" v-on:click="deleteUser(user.id)">
   							 <span class="glyphicon glyphicon-trash"></span> 删除
						</a>
			       </td>
			   </tr>
			  </tbody>
			</table> 
			<!-- 分页 -->
			
			<nav>
			  <ul class="pagination">
			    <li><a href="#">«</a></li>
			    <li class="active"><a href="#">1</a></li>
			    <li><a href="#">2</a></li>
			    <li><a href="#">3</a></li>
			    <li><a href="#">4</a></li>
			    <li><a href="#">5</a></li>
			    <li class="disabled"><a href="#">»</a></li>
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
			
		<div class="tab-pane" id="tab_essay">    
		<center> 
			<div class="input-group">
		      <input type="text" class="form-control" v-model="searchText" aria-label="...">
		      <div class="input-group-btn">
		        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">搜索<span class="caret"></span></button>
		        <ul class="dropdown-menu dropdown-menu-right" role="menu">
		         <!--  <li><a href="#" v-on:click="findEssayByTitle">查找文章名</a></li>
		          <li><a href="#" v-on:click="findEssayByAuthorId">查找作者</a></li>
		          <li><a href="#" v-on:click="findEssayById">查找文章ID</a></li> -->
		          <li class="divider"></li>
		          <li><a href="#" v-on:click="showEssay">全部文章</a></li>
		        </ul>
			  </div>
			</div>
			
			
			 <table class="table table-striped table-bordered table-hover  table-condensed"  style="width:80%;">
			  <thead>
			     <th>ID</th>
			     <th>文章名</th>
			     <th>浏览次数</th>
			     <th>发布时间</th>
			     <th>作者</th>
			     <th>分类</th>
			     <th>是否推荐</th>
			     <th></th>
			     <th></th>
			  </thead>
			  <tbody>
			     <tr v-for="essay in essays">
			       <td>{{essay.id}}</td>
			       <td>{{essay.title}}</td>
			       <td>{{essay.views}}</td>
			       <td>{{essay.time}}</td>
			       <td>{{essay.authorId}}</td>
			       <td>{{essay.category}}</td>
			       <td>{{essay.isHot}}</td>
			       <td>
			       		<a href="#" v-on:click="editEssay(essay.id)">
   							 <span class="glyphicon glyphicon-edit"></span> 编辑
						</a>
			       </td>
			       <td>
			       		<a href="#" v-on:click="deleteEssay(essay.id)">
   							 <span class="glyphicon glyphicon-trash"></span> 删除
						</a>
			       </td>
			   </tr>
			  </tbody>
			</table> 	
			<nav>
			  <ul class="pagination">
			    <li><a href="#">«</a></li>
			    <li class="active"><a href="#">1</a></li>
			    <li><a href="#">2</a></li>
			    <li><a href="#">3</a></li>
			    <li><a href="#">4</a></li>
			    <li><a href="#">5</a></li>
			    <li class="disabled"><a href="#">»</a></li>
			  </ul>
			</nav> 
		</center>
		</div>  
			
		<div class="tab-pane" id="tab_hot">      
			<p>What up girl, this is Section 3.</p>    
		</div> 
	</div>
</div>


<script>
	
	new Vue({
		el:"#tab_user",
		data:{
			users:'',
			findResult:false,
			searchText:'',
			username:'',
			password:'',
			name:'',
			phone:'',
			balance:0,
			power:1
		},
		methods:{
			Myaxios	(url,self){
				axios.get(url).then(function(response){
					if(response.data==null||response.data=="")
						self.findResult=true;
					else{
						self.users=response.data;
						self.findResult=false;	
					}
				}).catch(function(error){
					alert(error);
				})
			},
			checkSearch:function(){
				if(this.searchText==null||this.searchText==""){
					alert("请输入正确参数");
					return false;
				}
				return true;
			},
			showUser:function(){
				var url="http://localhost:8080/MyOil/userManager";
				this.$options.methods.Myaxios(url,this);
			}, 
			findUserById:function(){
				var url="http://localhost:8080/MyOil/findUserById?id="+this.searchText;
				this.$options.methods.Myaxios(url,this);
			},
			findUserByUsername:function(){
				var url="http://localhost:8080/MyOil/findUserByUsername?username="+this.searchText;
				this.$options.methods.Myaxios(url,this);
			},
			findUserByName:function(){
				var url="http://localhost:8080/MyOil/findUserByName?name="+this.searchText;
				this.$options.methods.Myaxios(url,this);
			},
			editUser:function(id){
				alert(id);
			},
			deleteUser:function(id){
				alert(id);
			},
			addUser:function(){
				var url="http://localhost:8080/MyOil/addUser?username="+this.username+"&password="+this.password+
						"&name="+this.name+"&phone="+this.phone+"&balance="+this.balance+"&power="+this.power;
				 
				axios.get(url).then(function(response){
					if(response.data=="success")
						alert("添加成功");
					else if(response.data=="fail")
						alert("该用户名已存在");
					else
						alert("添加失败");
				}).catch(function(eroor){
					alert(error);
				});
			    $("#myModal").modal('hide');
			}
		}
	})
	
	
	new Vue({
		el:"#tab_essay",
		data:{
			essays:'',
			findResult:false,
			searchText:'',
			essayTitle:'',
			id:'',
			authorId:''
		},
		methods:{
			checkSearch:function(){
				if(this.searchText==null||this.searchText==""){
					alert("请输入正确参数");
					return false;
				}
				return true;
			},
			showEssay:function(){
				url="http://localhost:8080/MyOil/getEssayList?num=20";
				self=this;
				axios.get(url).then(function(response){
					//console.log(JSON.stringify(response.data));
					self.essays=response.data;
				});
			}, 
			findEssayByTitle:function(){
			},
			findEssayByAuthorId:function(){
			},
			findEssayByID:function(){
			},
			editEssay:function(id){
				alert(id);
			},
			deleteEssay:function(id){
				alert(id);
			},
			addEssay:function(){
			}
		}
	});
</script>

</body>
</html>