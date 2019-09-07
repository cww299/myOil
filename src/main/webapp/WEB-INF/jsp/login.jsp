<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<script src="./static/bootstrap/js/jquery/2.0.0/jquery.min.js"></script>
<link href="./static/bootstrap/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="./static/bootstrap/js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="./static/Vue/vue.min.js"></script>
<script src="./static/Vue/axios.min.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>加油站管理 -会员登陆</title>
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">

<link href="./static/css/login.css" rel="stylesheet">

</head>
<body>
<%@include file="header.jsp" %>
<div id="pane">
	<div class="panel panel-info">
	  <div class="panel-heading">用户登陆</div>
	  <div class="panel-body">
	  	<div id="login">
		  	<table>
		  	<tr><td><span class="glyphicon glyphicon-user"></span>账号：</td>
				<td><input type="text" v-model="username" class="form-control" id="username"/></td><td></td></tr>
			<tr><td><span class="glyphicon glyphicon-lock"></span>密码：</td>
				<td><input type="password" v-model="password" class="form-control" id="password"/></td><td></td></tr>
			<tr><td><span class="glyphicon glyphicon-lock"></span>验证码：</td>
				<td><input type="text" v-model="yzm" class="form-control" id="yzm"/></td>
				<td><p v-on:click="getNewyzm">{{newyzm}}</p></td></tr>
			<tr><td colspan="2">
					<button type="button" class="btn btn-primary" v-on:click="login">登陆</button>
					<input type="checkbox" v-on:click="">自动登陆
					</td><td></td></tr>
			
			</table>
			<a href="">还没账号？点击注册</a>
	  	</div>
	  	<div id="imgs">
	  		<img src="./static/img/system/user.jpg">
	  	</div>
	  </div>
	</div>
</div>
<%@include file="floor.html" %>
</body>
<script>
	new Vue({
		el:"#pane",
		data:{
			username:'',
			password:'',
			yzm:'',
			newyzm:0
		},
		methods:{
			
			login:function(){
				self=this;
				//alert(self.username+"  "+self.password+"   "+self.yzm);
				if(self.username==""){
					document.getElementById("username").focus();
					alert("用户名不能为空！");
					return;
				}
				if(self.password==""){
					document.getElementById("password").focus();
					alert("密码不能为空！");
					return
				}
				if(self.yzm==""){
					document.getElementById("yzm").focus();
					alert("验证码不能为空！");
					return
				}
				if(self.yzm!=self.newyzm){
					document.getElementById("yzm").focus();
					alert("验证码错误！");
					return
				}
				url="http://localhost:8080/MyOil/login?username="+self.username+"&password="+self.password;
				axios.get(url).then(function(response){
					if(response.data=="noUsername"){
						alert("该账号不存在，请确认是否输入有误");
						document.getElementById("username").focus();
						return;
					}
					else if(response.data=="passwordError"){
						alert("密码错误");
						document.getElementById("password").focus();
						return;
					}else if(response.data=="success"){
						alert("登陆成功");
						window.location.href="http://localhost:8080/MyOil/index";
					}
				})
			},
			getNewyzm:function(){
				this.newyzm=Number(Math.random()*10000).toFixed();
				while(this.newyzm<1000)
					this.newyzm=Number(Math.random()*10000).toFixed();
				return;
			}
		},
		mounted:function(){
			while(this.newyzm<1000)
				this.newyzm=Number(Math.random()*10000).toFixed();
		}
	})
	
</script>
</html>
