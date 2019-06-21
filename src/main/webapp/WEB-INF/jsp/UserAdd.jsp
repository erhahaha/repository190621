<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户添加</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript">
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 

</script>
<!-- bootstrap-css -->
<link rel="stylesheet" href="${APP_PATH}/css/bootstrap.css">
<!-- //bootstrap-css -->
<!-- Custom CSS -->
<link href="${APP_PATH}/css/style.css" rel='stylesheet' type='text/css' />
<!-- font CSS -->
<link
	href='https://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>
<!-- font-awesome icons -->
<link rel="stylesheet" href="${APP_PATH}/css/font.css" type="text/css" />
<link rel="stylesheet"
	href="${APP_PATH}/assets/font-awesome/css/font-awesome.min.css"
	type="text/css">
<!-- //font-awesome icons -->
<script src="${APP_PATH}/js/jquery.min.js"></script>
<script src="${APP_PATH}/js/modernizr.js"></script>
<script src="${APP_PATH}/js/jquery.cookie.js"></script>
<script src="${APP_PATH}/js/screenfull.js"></script>
<script src="${APP_PATH}/js/dataShow.js"></script>
<script>
	$(function() {
		$('#supported').text('Supported/allowed: ' + !!screenfull.enabled);
		if (!screenfull.enabled) {
			return false;
		}
		$('#toggle').click(function() {
			screenfull.toggle($('#container')[0]);
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(
			function(e) {
				$("#btn_row").click(
						function() {
							$("#table_add tr").eq(0).append(
									"<td>第"
											+ ($("#table_add tr:eq(0) td")
													.size() + 1) + "列</td>");
						});
			});
</script>
<script src="${APP_PATH}/assets/js/echarts.js"></script>
<script src="${APP_PATH}/js/bootstrap.js"></script>
<!-- tables -->
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/css/table-style.css" />
<link rel="stylesheet" type="text/css"
	href="${APP_PATH}/css/basictable.css" />
<script type="text/javascript"
	src="${APP_PATH}/js/jquery.basictable.min.js"></script>
<!-- //tables -->
<script type="text/javascript">
	var pathName = window.document.location.pathname;
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);

	function checkUserid() {
		var userid = document.getElementById("userid").value;
		var html = "";
		if (userid == "") {
			html += "员工号不得为空！";
		} else {
			$.ajax({
				url : projectName + '/user/checkisuserid',
				type : "POST",
				data : "userid=" + userid,
				dataType : 'json',
				async : false,
				success : function(data) {
					if (data.object.result == "存在") {
						html += "员工号已存在！";
					}
				}
			})
		}
		$("#isuserid").html(html);
	}

	function checkUsername() {
		var username = document.getElementById("username").value;
		var html = "";
		if (username == "") {
			html += "用户名不得为空！";
		}
		$("#isusername").html(html);
	}

	function checkPassword() {
		var password = document.getElementById("password").value;
		var html = "";
		if (password == "") {
			html += "密码不得为空！";
		}
		$("#ispassword").html(html);
	}

	function confirmPassword() {
		var password = document.getElementById("password").value;
		var confirmpassword = document.getElementById("confirmpassword").value;
		var html = "";
		if (password != confirmpassword) {
			html += "两次密码输入不一致！";
		}
		$("#isconfirmpassword").html(html);
	}
</script>
</head>
<body class="dashboard-page">
	<nav class="main-menu">
	<ul>
		<li><a href="${APP_PATH}/sectionelem/enterhome"> <i
				class="fa fa-home nav_icon"></i> <span class="nav-text"> 主页 </span>
		</a></li>

		<li><a href="${APP_PATH}/sectionelem/tableshows"> <i
				class="icon-table nav-icon"></i> <span class="nav-text"> 数据查看
			</span>
		</a></li>
		<li><a href="javascript:;"> <i
				class="fa fa-bar-chart nav_icon"></i> <span class="nav-text">
					图表显示 </span><i class="icon-angle-right"></i><i class="icon-angle-down"></i>
		</a>
			<ul>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/enterdata">土地重金属含量统计</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/entertrend">土地重金属含量走势</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/analdata">土地重金属数据分析</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/analtrend">土地重金属变化图</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/proStatis/productStatistics">农作物重金属报表</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/productelem/enterproduct">农作物金属含量统计</a></li>
			</ul></li>
		<li class="has-subnav"><a
			href="${APP_PATH}/fileupload/enterinput"> <i
				class="fa fa-file-text-o nav_icon"></i> <span class="nav-text">
					文件导入</span>
		</a></li>
		<li class="has-subnav"><a href="javascript:;"> <i
				class="fa fa-cogs" aria-hidden="true"></i> <span class="nav-text">
					UI细节要素 </span> <i class="icon-angle-right"></i><i class="icon-angle-down"></i>
		</a>
			<ul>
				<li><a class="subnav-text" href="${APP_PATH}/user/userModify">
						用户信息修改 </a></li>
				<li><a class="subnav-text" href="${APP_PATH}/user/useradd">
						用户添加 </a></li>
				<li><a class="subnav-text" href="${APP_PATH}/user/userMana">
						用户管理 </a></li>
			</ul></li>
	</ul>
	<ul class="logout">
		<li><a href="${APP_PATH}/user/outLogin"> <i
				class="icon-off nav-icon"></i> <span class="nav-text"> 注销 </span>
		</a></li>
	</ul>
	</nav>
	<section class="wrapper scrollable"> <nav class="user-menu">
	<a href="javascript:;" class="main-menu-access"> <i
		class="icon-proton-logo"></i> <i class="icon-reorder"></i>
	</a> </nav> <section class="title-bar">
	<div class="logo" style="width:70%">
				<h2>
					<a href="#"><img src="${APP_PATH}/images/logo.png" alt="" />&nbsp;&nbsp;&nbsp;天津市农产品产地土壤重金属</a>
				</h2>
			</div>
			<div class="header-right" style="margin-right: 50px;">
				<div class="profile_details_left">
					<div class="profile_img" style="position: absolute;">	
							<span  class="prfil-img"><i class="fa fa-user"  style="width:33px;height:33px;"></i></span> 
								
					</div>	
					<div style="float:right;margin-left: 50px;margin-top: 5px;font-size:100%"><b>当前用户：${user.username}，
						<a href="/SoilenvironmentMana/user/outLogin" style="text-decoration: none;color: #90EE90;">注销</a></b>
					</div>
					<div class="clearfix"> </div>
				</div>
		 	</div>
	<div class="clearfix"></div>
	</section>
	<div class="main-grid">
		<div class="agile-grids">
			<!-- input-forms -->
			<div class="grids">
				<div class="data-title" style="margin-left: 5px">
					<h2 style="font-size: 150%; color: #00BCD4">
						<b>用 户 添 加</b>
					</h2>
				</div>
				<div class="panel panel-widget forms-panel w3-last-form"
					style="margin-top: 20px">
					<div class="forms">
						<div class="form-three widget-shadow">
							<div class=" panel-body-inputin">
								<form class="form-horizontal" id="newuseradd"
									onsubmit="return false;">
									<div class="form-group">
										<label class="col-md-2 control-label">员工号<span
											style="color: red">*</span></label>
										<div class="col-md-8">
											<div class="input-group">
												<span class="input-group-addon"> <i
													class="fa fa-bookmark-o"></i>
												</span> <input type="text" class="form-control1" id="userid"
													placeholder="员 工 号 . . ." onblur="checkUserid();">
											</div>
										</div>
										<span id="isuserid" style="color: red;"> </span>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">用户名<span
											style="color: red">*</span></label>
										<div class="col-md-8">
											<div class="input-group">
												<span class="input-group-addon"> <i
													class="fa fa-user"></i>
												</span> <input type="text" class="form-control1" id="username"
													placeholder="用 户 . . ." onblur="checkUsername();">
											</div>
										</div>
										<span id="isusername" style="color: red;"> </span>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">密码<span
											style="color: red">*</span></label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i class="fa fa-key"></i>
												</span> <input type="password" class="form-control1" id="password"
													placeholder="密 码  . . ." onblur="checkPassword();">
											</div>
										</div>
										<span id="ispassword" style="color: red;"> </span>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">密码确认<span
											style="color: red">*</span></label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i class="fa fa-key"></i>
												</span> <input type="password" class="form-control1"
													id="confirmpassword" placeholder="密 码 确 认 . . ."
													onblur="confirmPassword();">
											</div>
										</div>
										<span id="isconfirmpassword" style="color: red;"> </span>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">用户等级</label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i
													class="fa fa-navicon"></i>
												</span>
												<div>
													<select id="level" name="regionName"
														style="height: 38px; width: 100%;border-color: #cccccc">
														<option value="1">管理员</option>
														<option value="2">普通用户</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">职位<span
											style="color: red">*</span></label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i
													class="fa fa-globe"></i>
												</span> <input type="text" class="form-control1" id="job"
													placeholder="职 位 . . .">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">办公电话</label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i
													class="fa fa-phone"></i>
												</span> <input type="text" class="form-control1" id="jobphone"
													placeholder="办 公 电 话 . . .">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">联系电话</label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i class="fa fa-fax"></i>
												</span> <input type="text" class="form-control1" id="linkphone"
													placeholder="联 系 电 话 . . .">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">邮箱地址</label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i
													class="fa fa-envelope-o"></i>
												</span> <input id="email" class="form-control1" type="text"
													placeholder="邮 箱 地 址 . . .">
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">住址</label>
										<div class="col-md-8">
											<div class="input-group input-icon right">
												<span class="input-group-addon"> <i
													class="fa fa-home"></i>
												</span> <input id="address" class="form-control1" type="text"
													placeholder="住 址 . . .">
											</div>
										</div>
									</div>
									<div>
										<input type="submit" class="submitbtn" value="提交"
											style="width: 160px; height: 30px; color: #FFFFFF; background: #337AB7; border: none"
											onmousemove="this.style.backgroundColor='#286090';" onmouseout="this.style.backgroundColor='#337AB7';">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>