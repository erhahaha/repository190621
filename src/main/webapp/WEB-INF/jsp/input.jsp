<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>文件导入</title>
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
<link rel="stylesheet" type="text/css" href="${APP_PATH }/css/process.css">
<link rel="stylesheet"
	href="${APP_PATH}/assets/font-awesome/css/font-awesome.min.css"
	type="text/css">
<!-- //font-awesome icons -->
<script src="${APP_PATH}/js/jquery1.9.1.min.js"></script>
<script src="${APP_PATH}/js/modernizr.js"></script>
<script src="${APP_PATH}/js/jquery.cookie.js"></script>
<script src="${APP_PATH}/js/screenfull.js"></script>
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
<script src="${APP_PATH}/assets/js/echarts.js"></script>
<script src="${APP_PATH}/js/bootstrap.js"></script>

</head>
<body class="dashboard-page">
	<nav class="main-menu">
	<ul>
		<li><a href="${APP_PATH}/sectionelem/enterhome"> <i class="fa fa-home nav_icon"></i> <span
				class="nav-text"> 主页 </span>
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
		<li class="has-subnav">
			<a href="${APP_PATH}/fileupload/enterinput"> 
				<i class="fa fa-file-text-o nav_icon"></i> <span class="nav-text"> 文件导入</span>
			</a>
		</li>
		<li class="has-subnav"><a href="javascript:;"> <i
				class="fa fa-cogs" aria-hidden="true"></i> <span class="nav-text">
					UI细节要素 </span> <i class="icon-angle-right"></i><i class="icon-angle-down"></i>
		</a>
			<ul>
				<li><a class="subnav-text" href="${APP_PATH}/user/userModify"> 用户信息修改 </a></li>
				<li><a class="subnav-text" href="${APP_PATH}/user/useradd"> 用户添加 </a></li>
				<li><a class="subnav-text" href="${APP_PATH}/user/userMana"> 用户管理 </a></li>
			</ul></li>
	</ul>
	<ul class="logout">
		<li><a href="${APP_PATH}/user/outLogin"> <i class="icon-off nav-icon"></i> <span
				class="nav-text"> 注销 </span>
		</a></li>
	</ul>
	</nav>
	<section class="wrapper scrollable">
		<nav class="user-menu">
			<a href="javascript:;" class="main-menu-access"> 
			<i class="icon-proton-logo"></i> 
			<i class="icon-reorder"></i>
			</a> 
		</nav> 
		<section class="title-bar">
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
					<div class="grids">
						<div class="progressbar-heading grids-heading">
						<h2><b>文 件 导 入</b></h2>
						</div>
						<div class="panel panel-widget forms-panel">
						<div class="forms">
							<div class="form-grids widget-shadow" data-example-id="basic-forms"> 
								<div class="form-title">
									<h4>Excel表导入 :</h4>
								</div>
								<div class="form-body">
									<form action="/SoilenvironmentMana/fileupload/import" method="post" enctype="multipart/form-data"> 
										<div class="form-group"> 
											<input name="upfile" type="file" id="exampleInputFile"> 
											<p class="help-block">请选择要上传的文件</p> 
										</div> 
										<button id="upfile" type="submit" class="btn btn-default w3ls-button"style="background-color: #337AB7;border-color: #337AB7" onmousemove="this.style.backgroundColor='#286090';this.style.color='white'" onmouseout="this.style.backgroundColor='#337AB7';">导入</button> 
									</form> 
									<form action="${APP_PATH }/fileupload/fileoutput" method="post" enctype="multipart/form-data" style="margin-top: 20px">
									<input type="submit" value="样式表导出"
										style="width: 15%; height: 40px; font-size: 14px; background-color: #337AB7; color: white;font-weight:bold;border-style: none;"
										onmousemove="this.style.backgroundColor='#286090';" onmouseout="this.style.backgroundColor='#337AB7';">
									</form>
								</div>
							</div>
						</div>
					</div>
					</div>
				</div>
		</div>
	</section>
	<div style="width: 100px;height: 360px;margin-left: 50px;margin-top: 50px;float: left;">
				<div id="wait" class="blinking" hidden="true">
			        <span></span>
			        <span></span>
			        <span></span>
			        <span></span>
			        <span></span>
			        <span></span>
			        <span></span>
			        <span></span>
			    </div>
				
			</div>
	<script type="text/javascript">
		$(function(){
			$(document).ready(function(){
				$("#wait").attr("hidden",true);
			})
			$("#upfile").click(function(){
				$("#wait").attr("hidden",false);
				
			});
			
		
		})
	</script>   
	
</body>
</html>