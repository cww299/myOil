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
<title>加油站管理 -我的信息</title>
<link href="http://www.oilboss.cn/favicon.ico" rel="shortcut icon">
<style type="text/css">
#pane{
	width:80%;
	margin:0 auto;
}
.table{
	width:40%;
	margin:0 auto;	
	margin-top:20px;
	align:right;
}
</style>
</head>
<body>
<%@include file="header.jsp" %>
<div id="pane">
	<div class="panel panel-info">
	  <div class="panel-heading">我的信息</div>
	  	<table	class="table" style="width:40%;" id="myInfo">
	  		<tbody>
	  			<input type="hidden" id="userId" value="${user.id }">
	  			<tr><td align="right">ID:</td><td>${user.id }</td></tr>
	  			<tr><td align="right">用户名:</td>
	  				<td><input type="text" class="form-control" value="${user.username }"></td></tr>
	  			<tr><td align="right">密码:</td>
	  				<td><input type="password" class="form-control" value="${user.password }"></td></tr>
	  			<tr><td align="right">姓名:</td>
	  				<td><input type="text" class="form-control" value="${user.name }"></td></tr>
	  			<tr><td align="right">联系方式:</td>
	  				<td><input type="text" class="form-control" value="${user.phone }"></td></tr>
	  			<tr><td align="right">余额:</td>
	  				<td>${user.balance }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					<a href="#" data-toggle="modal" data-target="#myModal">账户充值</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  					<a href="#" v-on:click="getBill">账单查询</a></td></tr>
	  			<tr>
	  				<td align="right"><button type="button" class="btn btn-primary" v-on:click="update">修改</button></td>
	  				<td><button type="button" class="btn btn-primary" v-on:click="logout">注销</button></td>
	  			</tr>
	  			<div class="modal fade" id="myModal"  data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog">
					<div class="modal-content">
			          <div class="modal-header">
				            <button data-dismiss="modal" class="close" type="button">
				            	<span aria-hidden="true">×</span>
				            	<span class="sr-only">Close</span>
				            </button>
				            <h4 class="modal-title">确认充值</h4>
			          </div>
			          <div class="modal-body">
				          付款方式：
				            <select class="form-control" v-model="payModel">
				            	<option value="微信">微信</option>
				            	<option value="支付宝">支付宝</option>
				            </select>
				            <div style="width:80%;margin:0 auto;margin-top:5px;">	
				            	<p>充值金额：
				            	<div class="btn-group" data-toggle="buttons">
				            		<label class="btn btn-default active" v-on:click="rechargeNum(0)">
										<input type="radio" checked>其他
									</label>
							    	<label class="btn btn-default" v-on:click="rechargeNum(30)">
										<input type="radio" checked>30
									</label>
									<label class="btn btn-default"  v-on:click="rechargeNum(50)">
										<input type="radio">50
									</label>
									<label class="btn btn-default"  v-on:click="rechargeNum(100)">
										<input type="radio">100
									</label>
									<label class="btn btn-default"  v-on:click="rechargeNum(200)">
										<input type="radio">200
									</label>
									<label class="btn btn-default"  v-on:click="rechargeNum(500)">
										<input type="radio">500
									</label>
								</div><br>
				            	<input type="number" v-model="recharge" class="form-control" id="rechargeNum">
					            <div v-if="payModel=='微信'">
					            	<p>请扫描下方微信二维码付款：</p>
					            	<img src="./static/img/system/微信.jpg" width="200px;" height="300px;">
					            </div>
					            <div v-else="payModel=='支付宝'">
					            	<p>请扫描下方支付宝二维码付款：</p>
					            	<img src="./static/img/system/支付宝.jpg" width="200px;" height="300px;">
					            </div>
			            </div>
			          </div>
			          <div class="modal-footer">
			            	<button class="btn btn-primary" type="button" v-on:click="isRecharge">确认</button>
			          </div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
				</div>
	  		</tbody>
	  	</table>
		
	  	<table class="table table-hover" style="display:none;width:80%;" id="bill">
	  		<thead>
	  			<th>ID</th>
	  			<th>付款方式</th>
	  			<th>支付时间</th>
	  			<th>金额</th>
	  			<th>订单类型</th>
	  		</thead>
	  		<tbody>
	  			<tr v-for="order,index in orderList" v-on:click="showMore(index,order.id)">
	  				<td colspan="5">
	  					<table style="width:100%;text-align:center;">
	  						<thead>
	  							<th width="5%" style="">{{order.id}}</th>
				  				<th width="20%" style="text-align:center;">{{order.payModel}}</th>
				  				<th width="25%" style="text-align:center;">{{order.payTime}}</th>
				  				<th width="15%" style="text-align:center;">{{order.payMoney}}</th>
				  				<th width="25%" style="text-align:center;">{{order.orderType}}</th>
	  						</thead>
	  						<tbody v-if="show[index]" style="color:gray;test-align:center;font-size:6px;">
	  							<tr v-if="show[index]"><td colspan="2">订单详情：</td></tr>	
	  								<th width="5%" ></th>
	  								<th style="text-align:center;">商品名称</th>
	  								<th style="text-align:center;">规格/口味</th>
	  								<th style="text-align:center;">数量</th>
	  								<th style="text-align:center;">价格</th>
	  							<tr v-for="p in orderContent.list">
	  								<td></td>
	  								<td>{{p.pname}}</td>
	  								<td><span v-if="p.tname=='default'">--</span><span v-else>{{p.tname}}</span></td>
	  								<td>{{p.tprice}}</td>
	  								<td>{{p.buyNum}}</td>
	  							</tr>
	  						</tbody>
	  					</table>
	  				</td>
	  			</tr>
	  			
	  			
	  			
	  			<tr>
	  				<td colspan="5" style="text-align:center;">
		  				<nav>
							<ul class="pagination">
								<li >
									<span v-if="nowPage==1" style="background-color:#E0E0E0">上一页</span>
									<span v-else>
										<a href="#" v-on:click="turnPage(nowPage-1)">上一页</a>
									</span>
								</li>
								<li v-for="i in pageNum">
									<span v-if="nowPage==i" style="background-color:#E0E0E0">{{i}}</span>
									<span v-else>
										<a href="#" v-on:click="turnPage(i)">{{i}}</a>
									</span> 
								</li>
								<li>
									<span v-if="nowPage==pageNum" style="background-color:#E0E0E0">下一页</span>
									<span v-else>
										  <a href="#" v-on:click="turnPage(nowPage-1+2)">下一页</a>
									</span>
									<div class="resultNums">共：{{resultNums}}条记录</div>
								</li>
							 </ul>
						</nav> 
	  				</td>
	  			</tr>
	  		</tbody>
	  	</table>
	  
	  	<div style="float:right;">
	  		<c:if test="${user.power==2 }">
	  			<button type="button" class="btn btn-primary" v-on:click="manager">进入后台管理</button>
	  		</c:if>
	  	</div>
	  <div class="panel-body">
	  </div>
	</div>
</div>
<%@include file="floor.html" %>
</body>
<script>
	new Vue({
		el:"#pane",
		data:{
			payModel:'微信',
			recharge:0,
			orderList:[],
			nowPage:1,
			pageNum:5,
			resultNums:0,
			userId:0,
			orderContent:'',
			show:[false,false,false,false,false,false,false,false,false,false]
		},
		methods:{
			logout:function(){
				if(confirm("是否退出登陆?")==false)
					return;
				url="http://localhost:8080/MyOil/logout";
				axios.get(url).then(function(response){
					if(response.data=="success"){
						alert("注销成功");
						window.location.href="http://localhost:8080/MyOil/index";
					}
				})
			},
			rechargeNum:function(recharge){
				this.recharge=recharge;
				if(recharge!=0)
					document.getElementById("rechargeNum").setAttribute("readOnly",'true');
				else
					document.getElementById("rechargeNum").readOnly=false;
			},
			isRecharge:function(){
				var num=Number(this.recharge).toFixed(1);
				if(confirm("是否充值金额："+num+"元")!=true)
					return;
				url="http://localhost:8080/MyOil/recharge?recharge="+num+"&payModel="+this.payModel;
				axios.get(url).then(function(response){
					if(response.data=="success"){
						alert("充值成功");
						window.location.href="http://localhost:8080/MyOil/user";
					}
				})
			},
			getBill:function(){
				self=this;
				document.getElementById("myInfo").style.display="none";
				document.getElementById("bill").style.display="table";
				url="http://localhost:8080/MyOil/getOrderList?userId="+this.userId+"&nowPage="+this.nowPage;
				axios.get(url).then(function(response){
					self.orderList=response.data;
				});
			 	url="http://localhost:8080/MyOil/getOrderListResult?userId="+this.userId;
				axios.get(url).then(function(response){
					self.resultNums=Number(response.data).toFixed(0);
					self.pageNum=parseInt(self.resultNums/10+1);
				});
			},
			turnPage:function(page){
				this.nowPage=page;
				url="http://localhost:8080/MyOil/getOrderList?userId="+this.userId+"&nowPage="+this.nowPage;
				axios.get(url).then(function(response){
					self.orderList=response.data;
				});
			},
			showMore:function(index,id){
				self=this;
				for(i in this.show)
					this.show[i]=false;
				this.show[index]=true;
				//获取订单内容
				url="http://localhost:8080/MyOil/getOrderContent?id="+id;
				axios.get(url).then(function(response){
					self.orderContent=response.data[0];
				});
				//刷新页面
				url="http://localhost:8080/MyOil/getOrderList?userId="+this.userId+"&nowPage="+this.nowPage;
				axios.get(url).then(function(response){
					self.orderList=response.data;
					console.log(response.data);
				});
			},
			update:function(){
				
			},
			manager:function(){
				window.location.href="http://localhost:8080/MyOil/toManager";
			}
		},
		mounted:function(){
			this.userId=document.getElementById("userId").value;
		}
	})
	
</script>
</html>
