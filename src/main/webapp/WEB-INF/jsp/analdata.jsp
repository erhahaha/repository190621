<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>土壤重金属数据分析</title>
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
<link href="${APP_PATH}/css/mycss.css" rel='stylesheet' type='text/css' />
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
<script src="${APP_PATH}/js/initData.js"></script>
<script src="${APP_PATH}/js/dataShow.js"></script>
<script src="${APP_PATH}/js/dataShowadd.js"></script>

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
<script src="${APP_PATH}/assets/js/echarts.min.js"></script>
<script src="${APP_PATH}/js/bootstrap.js"></script>
<!-- tables -->
<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/table-style.css" />
<link rel="stylesheet" type="text/css" href="${APP_PATH}/css/basictable.css" />
<script type="text/javascript" src="${APP_PATH}/js/jquery.basictable.min.js"></script>
<!-- //tables -->
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
				class="fa fa-bar-chart nav_icon"></i> <span class="nav-text">图表显示
			</span> <i class="icon-angle-right"></i> <i class="icon-angle-down"></i>
		</a>
			<ul>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/enterdata">土地重金属含量统计</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/entertrend">土地重金属含量走势</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/analdata">土地重金属数据分析</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/sectionelem/analtrend">土地重金属变化图</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/proStatis/productStatistics">农作物重金属报表</a></li>
				<li><a class="subnav-text" href="${APP_PATH}/productelem/enterproduct">农作物金属含量统计</a></li>
			</ul></li>
		<li class="has-subnav"><a href="${APP_PATH}/input.jsp"> <i
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
			<div class="data-title" >
				<h2 style="font-size: 150%; color: #00BCD4">
					<b>天津市各行政区县采样点分析</b>
				</h2>
			</div>
			<div class="choose">
				<form id="numOfSamplePoints" onsubmit="return false;">
					<!-- <form  action="/SoilenvironmentMana//sectionelem/infoOfRegion"> -->
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年份： <select id="inityear"
						name="eleName">
					</select> <input id="allclick" type="submit" value="筛选数据"
						style="width: 160px; height: 30px; margin-left: 50px;">
				</form>
			</div>
			<div class="agile-tables">
				<div class="w3l-table-info">
					<table id="table">
						<thead id="tableHead">
							<tr>
								<th>区县</th>
								<th>东丽</th>
								<th>津南</th>
								<th>北辰</th>
								<th>西青</th>
								<th>汉沽</th>
								<th>塘沽</th>
								<th>大港</th>
								<th>宝坻</th>
								<th>宁河</th>
								<th>蓟州</th>
								<th>静海</th>
								<th>武清</th>
								<th>总数</th>
							</tr>
						</thead>
						<tbody id="tableBody">
							<td>采样点数</td>
						</tbody>
					</table>
				</div>
			</div>
			<div class="subtitle" style="margin-top: 10px;">
				<!-- <h2 style="font-size: 150%; color: #00BCD4;margin:auto;text-align: center">
					<b>采样点分析</b>
				</h2> -->
			</div>
			<div class="kindchoose" style="margin-top: 10px;">
				<form id="kindofanal" onsubmit="return false;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看种类：
						<select id ="detailKind">
								<option value="overproof">超标情况分析</option>
								<option value="securelevel">安全等级分析</option>
								<option value="pollutionlevel">污染情况分析</option>
								<option value="accumulatlevel">累积情况分析</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看方式：
						<select id="ways">
								<option value="op_pointall">点位超标情况分析(总)</option>
								<option value="op_pointregion">点位超标情况分析(区域)</option>
								<option value="op_mean">平均超标情况分析</option>
								<option value="op_count">超标点位数量统计</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年份： 
						<select id="inityear2"	name="eleName"></select> 
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;元素选择：
						<select id ="initelem" name="eleName"></select>
						<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地区选择： -->
						<select id ="initregion" name="regionName" disabled="disabled" style="visibility: hidden"></select>
						<input id="allclick2" type="submit" value="筛选数据"
						style="width: 160px; height: 30px; margin-left: -30px;">
				</form>
			</div>
		</div>
		<div class="main-body" >
				<div id="main-top" class="main-top" style=" width: 100%;">
							<h2 id="htitle" style="font-size: 150%;text-align: center;margin-top:10px  ;margin-bottom: -20px">
							</h2>
				</div>
				<div id="main-left" class="main-left" style=" width: 100%;">
					<div class="agile-grids">
						<div class="agile-tables">
							<div class="w3l-table-info">
							    <table id="table">
								<thead id="tableHead2" >
								</thead>
								<tbody id="tableBody2"> 
								</tbody>
							  </table>
							</div>
						</div>
					</div>				
				</div>
				<div id="map_anal" style="width: 50%; height: 600px;display:none;float: left"></div>
		</div>
		<div id="map_anal2" style="width: 600px; height: 600px;margin:auto;display:none;"></div>
		<div id="map_anal3" style="width: 1000px; height: 500px;margin:auto;display:none;"></div>
	</div>
	</section>
</body>
</html>