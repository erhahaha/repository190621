<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<title>农产品数据分析</title>
	
	<meta charset="UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!-- <link rel="stylesheet" type="text/css" href="my.css"> -->
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
	
	
	<script type="text/javascript" src="${APP_PATH }/js/jquery1.9.1.min.js"></script>
	<script type="text/javascript" src="${APP_PATH }/assets/js/echarts.min.js"></script>
	<script type="text/javascript" src="${APP_PATH }/js/jquery.yestop.js"></script>
	<script src="${APP_PATH}/js/bootstrap.js"></script>
	<script src="${APP_PATH}/js/modernizr.js"></script>
	<script src="${APP_PATH}/js/jquery.cookie.js"></script>
	<script src="${APP_PATH}/js/screenfull.js"></script> 
	<script src="${APP_PATH}/js/initData.js"></script> 
	<script>
		$(function() {
			$.fn.yestop(); 
			var sum='${sum[12]}';
			var over='${productEleOver[5][5]}';
			
			sum = parseFloat(sum);
		    over = parseFloat(over);
		
			var a=over/sum*100;
			var notover=sum-over;
			var c=100-a;
			var d=Math.round(notover/over);
			
			$("#a").html(a.toFixed(2)+"%");
			$("#b").html(notover);
			$("#c").html(c.toFixed(2)+"%");
			$("#d").html(d+":1");
		
			  
			var year='${scnCountListWheat[0].year}';
			if(year!=""){
				
				$("#year").val(year);
			}
			
			
			
			$('#supported').text('Supported/allowed: ' + !!screenfull.enabled);
			if (!screenfull.enabled) {
				return false;
			}
			$('#toggle').click(function() {
				screenfull.toggle($('#container')[0]);
			});
		});
	</script>
	
	<style type="text/css">
	body{
		text-align: left;
		
	}
		table
        {
            border-collapse: collapse;
            margin: 0 auto;
            font-size:16px;
            text-align: center;
        }
        table td
        {
            border: 1px solid #cad9ea;
            color: #2F4F4F;
            height: 20px;
            width:60px;
        }
        table th
        {
            background-color: #CCE8EB;
            
            color: #2F4F4F;
            height: 20px;
            width:60px;
            
        }
        table tr:nth-child(odd)
        {
            background: #fff;
        }
        table tr:nth-child(even)
        {
            background: #fff;
        }
      select{
                font-family: "微软雅黑";
                margin:10px;
                background: rgba(0,0,0,0);
                width: 100px;
                height: 30px;
                font-size: 16px;
                color: black;
                text-align: center;
                border: 1px #CFCFCF solid;
                border-radius: 2px;
            }
            option{
                color: black;
                background: #EFF3F6;
                line-height: 20px;
            }
            select:focus{
                border: 2px #ddd solid;
                box-shadow: 0 0 15px 1px #DDDDDD;
            }
            option:hover{
                background: #EBCCD1;
            }
            
             
        
     .container{width: 95%;background-color: #EEE5DE;padding-top: 10px;padding-left:10px; margin-bottom: 50px;margin-left: 26px;} 
     .contitle{width:100%;font-size: 23px;font-family: 微软雅黑;text-align: left;margin-bottom: 20px;}  
	</style>
	
	
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
			<div style="width: 90%;height: 50px;margin-left: 20px;margin-top: 30px;margin-bottom: 10px;">
				<form action="${APP_PATH }/proStatis/getProEleExtre" method="post">
					<select name="year" id="inityear">
					</select>
					<input type="submit" value="选择年份" style="width:100px;height:30px;font-size:18px;margin-left: 30px;border-radius: 5px;background-color: #354457;color:white;">
				</form>
			</div>
			
			<div style="width:90%;text-align: center;font-size: 30px;font-family: 微软雅黑;margin-bottom: 50px;">天津市${scnCountListWheat[0].year}年农产品产地农产品数据报表统计</div>
			
			<!-- 采样点数量统计 -->
			<div class="container">
				<div class="contitle">表12.	天津市不同农产品种植种类采样点数量分布</div>
				<div style="width: 90%;height: 200px;margin-left: 10px;">
					<div style="float: left;margin-left: 20px;">
						<table>
							<tr>
								<th></th>
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
								<th>总计</th>
							</tr>
							<tr>
								<td>小麦类</td>
								<td>${scnCountListWheat[0].count}</td>
								<td>${scnCountListWheat[1].count}</td>
								<td>${scnCountListWheat[2].count}</td>
								<td>${scnCountListWheat[3].count}</td>
								<td>${scnCountListWheat[4].count}</td>
								<td>${scnCountListWheat[5].count}</td>
								<td>${scnCountListWheat[6].count}</td>
								<td>${scnCountListWheat[7].count}</td>
								<td>${scnCountListWheat[8].count}</td>
								<td>${scnCountListWheat[9].count}</td>
								<td>${scnCountListWheat[10].count}</td>
								<td>${scnCountListWheat[11].count}</td>
								<th>${scnCountListWheat[12].allcount}</th>
							</tr>
							<tr>
								<td>水稻类</td>
								<td>${scnCountListRice[0].count}</td>
								<td>${scnCountListRice[1].count}</td>
								<td>${scnCountListRice[2].count}</td>
								<td>${scnCountListRice[3].count}</td>
								<td>${scnCountListRice[4].count}</td>
								<td>${scnCountListRice[5].count}</td>
								<td>${scnCountListRice[6].count}</td>
								<td>${scnCountListRice[7].count}</td>
								<td>${scnCountListRice[8].count}</td>
								<td>${scnCountListRice[9].count}</td>
								<td>${scnCountListRice[10].count}</td>
								<td>${scnCountListRice[11].count}</td>
								<th>${scnCountListRice[12].allcount}</th>
							</tr>
							<tr>
								<td>玉米类</td>
								<td>${scnCountListCorn[0].count}</td>
								<td>${scnCountListCorn[1].count}</td>
								<td>${scnCountListCorn[2].count}</td>
								<td>${scnCountListCorn[3].count}</td>
								<td>${scnCountListCorn[4].count}</td>
								<td>${scnCountListCorn[5].count}</td>
								<td>${scnCountListCorn[6].count}</td>
								<td>${scnCountListCorn[7].count}</td>
								<td>${scnCountListCorn[8].count}</td>
								<td>${scnCountListCorn[9].count}</td>
								<td>${scnCountListCorn[10].count}</td>
								<td>${scnCountListCorn[11].count}</td>
								<th>${scnCountListCorn[12].allcount}</th>
							</tr>
							<tr>
								<td>蔬菜类</td>
								<td>${scnCountListVegetables[0].count}</td>
								<td>${scnCountListVegetables[1].count}</td>
								<td>${scnCountListVegetables[2].count}</td>
								<td>${scnCountListVegetables[3].count}</td>
								<td>${scnCountListVegetables[4].count}</td>
								<td>${scnCountListVegetables[5].count}</td>
								<td>${scnCountListVegetables[6].count}</td>
								<td>${scnCountListVegetables[7].count}</td>
								<td>${scnCountListVegetables[8].count}</td>
								<td>${scnCountListVegetables[9].count}</td>
								<td>${scnCountListVegetables[10].count}</td>
								<td>${scnCountListVegetables[11].count}</td>
								<th>${scnCountListVegetables[12].allcount}</th>
							</tr>
							<tr>
								<td>其他类</td>
								<td>${scnCountListOther[0].count}</td>
								<td>${scnCountListOther[1].count}</td>
								<td>${scnCountListOther[2].count}</td>
								<td>${scnCountListOther[3].count}</td>
								<td>${scnCountListOther[4].count}</td>
								<td>${scnCountListOther[5].count}</td>
								<td>${scnCountListOther[6].count}</td>
								<td>${scnCountListOther[7].count}</td>
								<td>${scnCountListOther[8].count}</td>
								<td>${scnCountListOther[9].count}</td>
								<td>${scnCountListOther[10].count}</td>
								<td>${scnCountListOther[11].count}</td>
								<th>${scnCountListOther[12].allcount}</th>
							</tr>
							<tr>
								<td>总计</td>
								<th>${sum[0]}</th>
								<th>${sum[1]}</th>
								<th>${sum[2]}</th>
								<th>${sum[3]}</th>
								<th>${sum[4]}</th>
								<th>${sum[5]}</th>
								<th>${sum[6]}</th>
								<th>${sum[7]}</th>
								<th>${sum[8]}</th>
								<th>${sum[9]}</th>
								<th>${sum[10]}</th>
								<th>${sum[11]}</th>
								<th>${sum[12]}</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<!-- 重金属极值和平均值 -->
			<div class="container">
				<div class="contitle">表13.	天津市农产品重金属极值和平均值</div>
				<div style="width: 100%;height: 500px;margin-left: 10px;">
					<div style="float: left;margin-left: 20px;">
						<p>小麦类</p><br>
						<table>
							<tr>
								<th></th>
								<th>Cd</th>
								<th>Hg</th>
								<th>As</th>
								<th>Cu</th>
								<th>Pb</th>
								<th>Cr</th>
								<th>Zn</th>
								<th>Ni</th>
							</tr>
							<tr>
								<td>最大值</td>
								<td>${eleExtreListWheat[0].max}</td>
								<td>${eleExtreListWheat[1].max}</td>
								<td>${eleExtreListWheat[2].max}</td>
								<td>${eleExtreListWheat[3].max}</td>
								<td>${eleExtreListWheat[4].max}</td>
								<td>${eleExtreListWheat[5].max}</td>
								<td>${eleExtreListWheat[6].max}</td>
								<td>${eleExtreListWheat[7].max}</td>
							</tr>
							<tr>
								<td>最小值</td>
								<td>${eleExtreListWheat[0].min}</td>
								<td>${eleExtreListWheat[1].min}</td>
								<td>${eleExtreListWheat[2].min}</td>
								<td>${eleExtreListWheat[3].min}</td>
								<td>${eleExtreListWheat[4].min}</td>
								<td>${eleExtreListWheat[5].min}</td>
								<td>${eleExtreListWheat[6].min}</td>
								<td>${eleExtreListWheat[7].min}</td>
							</tr>
							<tr>
								<td>平均值</td>
								<td>${eleExtreListWheat[0].avg}</td>
								<td>${eleExtreListWheat[1].avg}</td>
								<td>${eleExtreListWheat[2].avg}</td>
								<td>${eleExtreListWheat[3].avg}</td>
								<td>${eleExtreListWheat[4].avg}</td>
								<td>${eleExtreListWheat[5].avg}</td>
								<td>${eleExtreListWheat[6].avg}</td>
								<td>${eleExtreListWheat[7].avg}</td>
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>水稻类</p><br>
						<table>
							<tr>
								<th></th>
								<th>Cd</th>
								<th>Hg</th>
								<th>As</th>
								<th>Cu</th>
								<th>Pb</th>
								<th>Cr</th>
								<th>Zn</th>
								<th>Ni</th>
							</tr>
							<tr>
								<td>最大值</td>
								<td>${eleExtreListRice[0].max}</td>
								<td>${eleExtreListRice[1].max}</td>
								<td>${eleExtreListRice[2].max}</td>
								<td>${eleExtreListRice[3].max}</td>
								<td>${eleExtreListRice[4].max}</td>
								<td>${eleExtreListRice[5].max}</td>
								<td>${eleExtreListRice[6].max}</td>
								<td>${eleExtreListRice[7].max}</td>
							</tr>
							<tr>
								<td>最小值</td>
								<td>${eleExtreListRice[0].min}</td>
								<td>${eleExtreListRice[1].min}</td>
								<td>${eleExtreListRice[2].min}</td>
								<td>${eleExtreListRice[3].min}</td>
								<td>${eleExtreListRice[4].min}</td>
								<td>${eleExtreListRice[5].min}</td>
								<td>${eleExtreListRice[6].min}</td>
								<td>${eleExtreListRice[7].min}</td>
							</tr>
							<tr>
								<td>平均值</td>
								<td>${eleExtreListRice[0].avg}</td>
								<td>${eleExtreListRice[1].avg}</td>
								<td>${eleExtreListRice[2].avg}</td>
								<td>${eleExtreListRice[3].avg}</td>
								<td>${eleExtreListRice[4].avg}</td>
								<td>${eleExtreListRice[5].avg}</td>
								<td>${eleExtreListRice[6].avg}</td>
								<td>${eleExtreListRice[7].avg}</td>
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>玉米类</p><br>
						<table>
							<tr>
								<th></th>
								<th>Cd</th>
								<th>Hg</th>
								<th>As</th>
								<th>Cu</th>
								<th>Pb</th>
								<th>Cr</th>
								<th>Zn</th>
								<th>Ni</th>
							</tr>
							<tr>
								<td>最大值</td>
								<td>${eleExtreListCorn[0].max}</td>
								<td>${eleExtreListCorn[1].max}</td>
								<td>${eleExtreListCorn[2].max}</td>
								<td>${eleExtreListCorn[3].max}</td>
								<td>${eleExtreListCorn[4].max}</td>
								<td>${eleExtreListCorn[5].max}</td>
								<td>${eleExtreListCorn[6].max}</td>
								<td>${eleExtreListCorn[7].max}</td>
							</tr>
							<tr>
								<td>最小值</td>
								<td>${eleExtreListCorn[0].min}</td>
								<td>${eleExtreListCorn[1].min}</td>
								<td>${eleExtreListCorn[2].min}</td>
								<td>${eleExtreListCorn[3].min}</td>
								<td>${eleExtreListCorn[4].min}</td>
								<td>${eleExtreListCorn[5].min}</td>
								<td>${eleExtreListCorn[6].min}</td>
								<td>${eleExtreListCorn[7].min}</td>
							</tr>
							<tr>
								<td>平均值</td>
								<td>${eleExtreListCorn[0].avg}</td>
								<td>${eleExtreListCorn[1].avg}</td>
								<td>${eleExtreListCorn[2].avg}</td>
								<td>${eleExtreListCorn[3].avg}</td>
								<td>${eleExtreListCorn[4].avg}</td>
								<td>${eleExtreListCorn[5].avg}</td>
								<td>${eleExtreListCorn[6].avg}</td>
								<td>${eleExtreListCorn[7].avg}</td>
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>蔬菜类</p><br>
						<table>
							<tr>
								<th></th>
								<th>Cd</th>
								<th>Hg</th>
								<th>As</th>
								<th>Cu</th>
								<th>Pb</th>
								<th>Cr</th>
								<th>Zn</th>
								<th>Ni</th>
							</tr>
							<tr>
								<td>最大值</td>
								<td>${eleExtreListVegetables[0].max}</td>
								<td>${eleExtreListVegetables[1].max}</td>
								<td>${eleExtreListVegetables[2].max}</td>
								<td>${eleExtreListVegetables[3].max}</td>
								<td>${eleExtreListVegetables[4].max}</td>
								<td>${eleExtreListVegetables[5].max}</td>
								<td>${eleExtreListVegetables[6].max}</td>
								<td>${eleExtreListVegetables[7].max}</td>
							</tr>
							<tr>
								<td>最小值</td>
								<td>${eleExtreListVegetables[0].min}</td>
								<td>${eleExtreListVegetables[1].min}</td>
								<td>${eleExtreListVegetables[2].min}</td>
								<td>${eleExtreListVegetables[3].min}</td>
								<td>${eleExtreListVegetables[4].min}</td>
								<td>${eleExtreListVegetables[5].min}</td>
								<td>${eleExtreListVegetables[6].min}</td>
								<td>${eleExtreListVegetables[7].min}</td>
							</tr>
							<tr>
								<td>平均值</td>
								<td>${eleExtreListVegetables[0].avg}</td>
								<td>${eleExtreListVegetables[1].avg}</td>
								<td>${eleExtreListVegetables[2].avg}</td>
								<td>${eleExtreListVegetables[3].avg}</td>
								<td>${eleExtreListVegetables[4].avg}</td>
								<td>${eleExtreListVegetables[5].avg}</td>
								<td>${eleExtreListVegetables[6].avg}</td>
								<td>${eleExtreListVegetables[7].avg}</td>
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>其他类</p><br>
						<table>
							<tr>
								<th></th>
								<th>Cd</th>
								<th>Hg</th>
								<th>As</th>
								<th>Cu</th>
								<th>Pb</th>
								<th>Cr</th>
								<th>Zn</th>
								<th>Ni</th>
							</tr>
							<tr>
								<td>最大值</td>
								<td>${eleExtreListOther[0].max}</td>
								<td>${eleExtreListOther[1].max}</td>
								<td>${eleExtreListOther[2].max}</td>
								<td>${eleExtreListOther[3].max}</td>
								<td>${eleExtreListOther[4].max}</td>
								<td>${eleExtreListOther[5].max}</td>
								<td>${eleExtreListOther[6].max}</td>
								<td>${eleExtreListOther[7].max}</td>
							</tr>
							<tr>
								<td>最小值</td>
								<td>${eleExtreListOther[0].min}</td>
								<td>${eleExtreListOther[1].min}</td>
								<td>${eleExtreListOther[2].min}</td>
								<td>${eleExtreListOther[3].min}</td>
								<td>${eleExtreListOther[4].min}</td>
								<td>${eleExtreListOther[5].min}</td>
								<td>${eleExtreListOther[6].min}</td>
								<td>${eleExtreListOther[7].min}</td>
							</tr>
							<tr>
								<td>平均值</td>
								<td>${eleExtreListOther[0].avg}</td>
								<td>${eleExtreListOther[1].avg}</td>
								<td>${eleExtreListOther[2].avg}</td>
								<td>${eleExtreListOther[3].avg}</td>
								<td>${eleExtreListOther[4].avg}</td>
								<td>${eleExtreListOther[5].avg}</td>
								<td>${eleExtreListOther[6].avg}</td>
								<td>${eleExtreListOther[7].avg}</td>
							</tr>
						</table>
					</div>	
				</div>
			</div>	 
			
			
			<!-- 表14.	天津市农产品产地采样点农产品重金属超标情况 -->
			<div class="container">
				<div class="contitle">表14.	天津市农产品产地采样点农产品重金属超标情况</div>
				<div style="width: 100%;height: 80px;margin-left: 10px;">
				<div style="float: left;margin-left: 20px;">
					<table>
							<tr>
								<th style="width:130px;">采样点</th>
								<th style="width:130px;">超标点数量</th>
								<th style="width:130px;">采样点超标率</th>
								<th style="width:130px;">未超标点数量</th>
								<th style="width:130px;">采样点未超标率</th>
								<th style="width:130px;">未超标/超标</th>
							</tr>
							<tr>
								<td>${sum[12]}</td>
								<td>${productEleOver[5][5]}</td>	
								<td id="a"></td>
								<td id="b"></td>
								<td id="c"></td>
								<td id="d"></td>
							</tr>
							
							
						</table>
				</div>
				</div>
			</div>
			
			
			
			<!-- 表15.	天津市农产品产地各行政区县农产品重金属超标情况-->
			<div class="container">
				<div class="contitle">表15.	天津市农产品产地各行政区县农产品重金属超标情况</div>
				<div style="width: 100%;height: 130px;margin-left: 10px;">
					<div style="float: left;margin-left: 20px;">
						<table>
							<tr>
								<th style="width:130px;">区县名称</th>
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
								<th>总计</th>
							</tr>
							
							<tr>
								<td>采样点数量</td>
								<td>${sum[0]}</td>
								<td>${sum[1]}</td>
								<td>${sum[2]}</td>
								<td>${sum[3]}</td>
								<td>${sum[4]}</td>
								<td>${sum[5]}</td>
								<td>${sum[6]}</td>
								<td>${sum[7]}</td>
								<td>${sum[8]}</td>
								<td>${sum[9]}</td>
								<td>${sum[10]}</td>
								<td>${sum[11]}</td>
								<td>${sum[12]}</td>
							</tr>
							<tr>
								<td>超标采样点数量</td>
								<td>${sectionEleOver[5][0]}</td>
								<td>${sectionEleOver[5][1]}</td>
								<td>${sectionEleOver[5][2]}</td>
								<td>${sectionEleOver[5][3]}</td>
								<td>${sectionEleOver[5][4]}</td>
								<td>${sectionEleOver[5][5]}</td>
								<td>${sectionEleOver[5][6]}</td>
								<td>${sectionEleOver[5][7]}</td>
								<td>${sectionEleOver[5][8]}</td>
								<td>${sectionEleOver[5][9]}</td>
								<td>${sectionEleOver[5][10]}</td>
								<td>${sectionEleOver[5][11]}</td>
								<td>${sectionEleOver[5][12]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${sum[0] eq 0 ? 0 : sectionEleOver[5][0]/sum[0]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[1] eq 0 ? 0 : sectionEleOver[5][1]/sum[1]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[2] eq 0 ? 0 : sectionEleOver[5][2]/sum[2]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[3] eq 0 ? 0 : sectionEleOver[5][3]/sum[3]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[4] eq 0 ? 0 : sectionEleOver[5][4]/sum[4]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[5] eq 0 ? 0 : sectionEleOver[5][5]/sum[5]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[6] eq 0 ? 0 : sectionEleOver[5][6]/sum[6]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[7] eq 0 ? 0 : sectionEleOver[5][7]/sum[7]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[8] eq 0 ? 0 : sectionEleOver[5][8]/sum[8]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[9] eq 0 ? 0 : sectionEleOver[5][9]/sum[9]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[10] eq 0 ? 0 : sectionEleOver[5][10]/sum[10]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[11] eq 0 ? 0 : sectionEleOver[5][11]/sum[11]*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${sum[12] eq 0 ? 0 : sectionEleOver[5][12]/sum[12]*100}" maxFractionDigits="2" /></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			
			
			<!-- 表16.	天津市行政区县农产品各类重金属超标情况 -->
			<div class="container">
				<div class="contitle">表16.	天津市行政区县农产品各类重金属超标情况</div>
				<div style="width: 100%;height: 180px;margin-left: 10px;">
					 <div style="float: left;margin-left: 20px;">
						
						<table>
							<tr>
								<th></th>
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
								<th>总计</th>
							</tr>
							<tr>
								<td>As</td>
								<td>${sectionEleOver[0][0]}</td>
								<td>${sectionEleOver[0][1]}</td>
								<td>${sectionEleOver[0][2]}</td>
								<td>${sectionEleOver[0][3]}</td>
								<td>${sectionEleOver[0][4]}</td>
								<td>${sectionEleOver[0][5]}</td>
								<td>${sectionEleOver[0][6]}</td>
								<td>${sectionEleOver[0][7]}</td>
								<td>${sectionEleOver[0][8]}</td>
								<td>${sectionEleOver[0][9]}</td>
								<td>${sectionEleOver[0][10]}</td>
								<td>${sectionEleOver[0][11]}</td>
								<td>${sectionEleOver[0][12]}</td>	
							</tr>
							<tr>
								<td>Hg</td>
								<td>${sectionEleOver[1][0]}</td>
								<td>${sectionEleOver[1][1]}</td>
								<td>${sectionEleOver[1][2]}</td>
								<td>${sectionEleOver[1][3]}</td>
								<td>${sectionEleOver[1][4]}</td>
								<td>${sectionEleOver[1][5]}</td>
								<td>${sectionEleOver[1][6]}</td>
								<td>${sectionEleOver[1][7]}</td>
								<td>${sectionEleOver[1][8]}</td>
								<td>${sectionEleOver[1][9]}</td>
								<td>${sectionEleOver[1][10]}</td>
								<td>${sectionEleOver[1][11]}</td>
								<td>${sectionEleOver[1][12]}</td>
							</tr>
							<tr>
								<td>Pb</td>
								<td>${sectionEleOver[2][0]}</td>
								<td>${sectionEleOver[2][1]}</td>
								<td>${sectionEleOver[2][2]}</td>
								<td>${sectionEleOver[2][3]}</td>
								<td>${sectionEleOver[2][4]}</td>
								<td>${sectionEleOver[2][5]}</td>
								<td>${sectionEleOver[2][6]}</td>
								<td>${sectionEleOver[2][7]}</td>
								<td>${sectionEleOver[2][8]}</td>
								<td>${sectionEleOver[2][9]}</td>
								<td>${sectionEleOver[2][10]}</td>
								<td>${sectionEleOver[2][11]}</td>
								<td>${sectionEleOver[2][12]}</td>
							</tr>
							<tr>
								<td>Cd</td>
								<td>${sectionEleOver[3][0]}</td>
								<td>${sectionEleOver[3][1]}</td>
								<td>${sectionEleOver[3][2]}</td>
								<td>${sectionEleOver[3][3]}</td>
								<td>${sectionEleOver[3][4]}</td>
								<td>${sectionEleOver[3][5]}</td>
								<td>${sectionEleOver[3][6]}</td>
								<td>${sectionEleOver[3][7]}</td>
								<td>${sectionEleOver[3][8]}</td>
								<td>${sectionEleOver[3][9]}</td>
								<td>${sectionEleOver[3][10]}</td>
								<td>${sectionEleOver[3][11]}</td>
								<td>${sectionEleOver[3][12]}</td>
							</tr>
							<tr>
								<td>Cr</td>
								<td>${sectionEleOver[4][0]}</td>
								<td>${sectionEleOver[4][1]}</td>
								<td>${sectionEleOver[4][2]}</td>
								<td>${sectionEleOver[4][3]}</td>
								<td>${sectionEleOver[4][4]}</td>
								<td>${sectionEleOver[4][5]}</td>
								<td>${sectionEleOver[4][6]}</td>
								<td>${sectionEleOver[4][7]}</td>
								<td>${sectionEleOver[4][8]}</td>
								<td>${sectionEleOver[4][9]}</td>
								<td>${sectionEleOver[4][10]}</td>
								<td>${sectionEleOver[4][11]}</td>
								<td>${sectionEleOver[4][12]}</td>
							</tr>
							
							
						</table>
					</div>
				</div>
			</div>
			
			
			
			<!-- 表17.	不同种植类型的农产品重金属超标情况 -->
			<div class="container">
				<div class="contitle">表17.	不同种植类型的农产品重金属超标情况</div>
				<div style="width: 100%;height: 830px;margin-left: 10px;">
					 <div style="margin-left: 20px;width:100%;height: 230px;">
						
						<table style="text-align: left;float: left;">
							<tr>
								<th></th>
								<th style="width:100px;">样点数量<br>（单位：个）</th>
								<th style="width:100px;">超标点数量（单位：个）</th>
								
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>小麦</td>
								<td>${scnCountListWheat[12].allcount}</td>
								<td>${productEleOver[0][5]}</td>
								<td>${productEleOver[0][0]}</td>
								<td>${productEleOver[0][1]}</td>
								<td>${productEleOver[0][2]}</td>
								<td>${productEleOver[0][3]}</td>
								<td>${productEleOver[0][4]}</td>	
							</tr>
							<tr>
								<td>水稻</td>
								<td>${scnCountListRice[12].allcount}</td>
								<td>${productEleOver[1][5]}</td>
								<td>${productEleOver[1][0]}</td>
								<td>${productEleOver[1][1]}</td>
								<td>${productEleOver[1][2]}</td>
								<td>${productEleOver[1][3]}</td>
								<td>${productEleOver[1][4]}</td>
								
							</tr>
							<tr>
								<td>玉米</td>
								<td>${scnCountListCorn[12].allcount}</td>
								<td>${productEleOver[2][5]}</td>
								<td>${productEleOver[2][0]}</td>
								<td>${productEleOver[2][1]}</td>
								<td>${productEleOver[2][2]}</td>
								<td>${productEleOver[2][3]}</td>
								<td>${productEleOver[2][4]}</td>
								
							</tr>
							<tr>
								<td>蔬菜</td>
								<td>${scnCountListVegetables[12].allcount}</td>
								<td>${productEleOver[3][5]}</td>
								<td>${productEleOver[3][0]}</td>
								<td>${productEleOver[3][1]}</td>
								<td>${productEleOver[3][2]}</td>
								<td>${productEleOver[3][3]}</td>
								<td>${productEleOver[3][4]}</td>
								
							</tr>
							<tr>
								<td>其他</td>
								<td>${scnCountListOther[12].allcount}</td>
								<td>${productEleOver[4][5]}</td>
								<td>${productEleOver[4][0]}</td>
								<td>${productEleOver[4][1]}</td>
								<td>${productEleOver[4][2]}</td>
								<td>${productEleOver[4][3]}</td>
								<td>${productEleOver[4][4]}</td>
								
							</tr>
							<tr>
								<td>总计</td>
								<td>${sum[12]}</td>
								<td>${productEleOver[5][5]}</td>
								<td>${productEleOver[5][0]}</td>
								<td>${productEleOver[5][1]}</td>
								<td>${productEleOver[5][2]}</td>
								<td>${productEleOver[5][3]}</td>
								<td>${productEleOver[5][4]}</td>
								
							</tr>
							
						</table>
					</div>
					<div class="contitle">图10. 各类农产品重金属点位超标数量情况</div>
					<div id="main18-1" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main18-2" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main18-3" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main18-4" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main18-5" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
						
				</div>	
				
			</div>	 
			
			<!-- 表19.	小麦类农产品重金属各区县数量超标情况 -->
			<div class="container">
				<div class="contitle">表19.	各类农产品重金属各区县数量超标情况</div>
				<div style="width: 100%;height: 800px;margin-left: 10px;">
				<div style="float: left;margin-left: 20px;">
						<p>小麦类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>小麦类采样点</td>
								<td>${scnCountListWheat[0].count}</td>
								<td>${scnCountListWheat[1].count}</td>
								<td>${scnCountListWheat[2].count}</td>
								<td>${scnCountListWheat[3].count}</td>
								<td>${scnCountListWheat[4].count}</td>
								<td>${scnCountListWheat[5].count}</td>
								<td>${scnCountListWheat[6].count}</td>
								<td>${scnCountListWheat[7].count}</td>
								<td>${scnCountListWheat[8].count}</td>
								<td>${scnCountListWheat[9].count}</td>
								<td>${scnCountListWheat[10].count}</td>
								<td>${scnCountListWheat[11].count}</td>
							</tr>
							<tr>
								<td>小麦类超标点</td>
								<td>${proSecOver[0][0]}</td>
								<td>${proSecOver[0][1]}</td>
								<td>${proSecOver[0][2]}</td>
								<td>${proSecOver[0][3]}</td>
								<td>${proSecOver[0][4]}</td>
								<td>${proSecOver[0][5]}</td>
								<td>${proSecOver[0][6]}</td>
								<td>${proSecOver[0][7]}</td>
								<td>${proSecOver[0][8]}</td>
								<td>${proSecOver[0][9]}</td>
								<td>${proSecOver[0][10]}</td>
								<td>${proSecOver[0][11]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[0].count eq 0 ? 0 : proSecOver[0][0]/scnCountListWheat[0].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[1].count eq 0 ? 0 : proSecOver[0][1]/scnCountListWheat[1].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[2].count eq 0 ? 0 : proSecOver[0][2]/scnCountListWheat[2].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[3].count eq 0 ? 0 : proSecOver[0][3]/scnCountListWheat[3].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[4].count eq 0 ? 0 : proSecOver[0][4]/scnCountListWheat[4].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[5].count eq 0 ? 0 : proSecOver[0][5]/scnCountListWheat[5].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[6].count eq 0 ? 0 : proSecOver[0][6]/scnCountListWheat[6].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[7].count eq 0 ? 0 : proSecOver[0][7]/scnCountListWheat[7].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[8].count eq 0 ? 0 : proSecOver[0][8]/scnCountListWheat[8].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[9].count eq 0 ? 0 : proSecOver[0][9]/scnCountListWheat[9].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[10].count eq 0 ? 0 : proSecOver[0][10]/scnCountListWheat[10].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListWheat[11].count eq 0 ? 0 : proSecOver[0][11]/scnCountListWheat[11].count*100}" maxFractionDigits="2" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>水稻类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>水稻类采样点</td>
								<td>${scnCountListRice[0].count}</td>
								<td>${scnCountListRice[1].count}</td>
								<td>${scnCountListRice[2].count}</td>
								<td>${scnCountListRice[3].count}</td>
								<td>${scnCountListRice[4].count}</td>
								<td>${scnCountListRice[5].count}</td>
								<td>${scnCountListRice[6].count}</td>
								<td>${scnCountListRice[7].count}</td>
								<td>${scnCountListRice[8].count}</td>
								<td>${scnCountListRice[9].count}</td>
								<td>${scnCountListRice[10].count}</td>
								<td>${scnCountListRice[11].count}</td>
							</tr>
							<tr>
								<td>水稻类超标点</td>
								<td>${proSecOver[1][0]}</td>
								<td>${proSecOver[1][1]}</td>
								<td>${proSecOver[1][2]}</td>
								<td>${proSecOver[1][3]}</td>
								<td>${proSecOver[1][4]}</td>
								<td>${proSecOver[1][5]}</td>
								<td>${proSecOver[1][6]}</td>
								<td>${proSecOver[1][7]}</td>
								<td>${proSecOver[1][8]}</td>
								<td>${proSecOver[1][9]}</td>
								<td>${proSecOver[1][10]}</td>
								<td>${proSecOver[1][11]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[0].count eq 0 ? 0 : proSecOver[1][0]/scnCountListRice[0].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[1].count eq 0 ? 0 : proSecOver[1][1]/scnCountListRice[1].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[2].count eq 0 ? 0 : proSecOver[1][2]/scnCountListRice[2].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[3].count eq 0 ? 0 : proSecOver[1][3]/scnCountListRice[3].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[4].count eq 0 ? 0 : proSecOver[1][4]/scnCountListRice[4].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[5].count eq 0 ? 0 : proSecOver[1][5]/scnCountListRice[5].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[6].count eq 0 ? 0 : proSecOver[1][6]/scnCountListRice[6].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[7].count eq 0 ? 0 : proSecOver[1][7]/scnCountListRice[7].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[8].count eq 0 ? 0 : proSecOver[1][8]/scnCountListRice[8].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[9].count eq 0 ? 0 : proSecOver[1][9]/scnCountListRice[9].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[10].count eq 0 ? 0 : proSecOver[1][10]/scnCountListRice[10].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListRice[11].count eq 0 ? 0 : proSecOver[1][11]/scnCountListRice[11].count*100}" maxFractionDigits="2" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>玉米类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>玉米类采样点</td>
								<td>${scnCountListCorn[0].count}</td>
								<td>${scnCountListCorn[1].count}</td>
								<td>${scnCountListCorn[2].count}</td>
								<td>${scnCountListCorn[3].count}</td>
								<td>${scnCountListCorn[4].count}</td>
								<td>${scnCountListCorn[5].count}</td>
								<td>${scnCountListCorn[6].count}</td>
								<td>${scnCountListCorn[7].count}</td>
								<td>${scnCountListCorn[8].count}</td>
								<td>${scnCountListCorn[9].count}</td>
								<td>${scnCountListCorn[10].count}</td>
								<td>${scnCountListCorn[11].count}</td>
							</tr>
							<tr>
								<td>玉米类超标点</td>
								<td>${proSecOver[2][0]}</td>
								<td>${proSecOver[2][1]}</td>
								<td>${proSecOver[2][2]}</td>
								<td>${proSecOver[2][3]}</td>
								<td>${proSecOver[2][4]}</td>
								<td>${proSecOver[2][5]}</td>
								<td>${proSecOver[2][6]}</td>
								<td>${proSecOver[2][7]}</td>
								<td>${proSecOver[2][8]}</td>
								<td>${proSecOver[2][9]}</td>
								<td>${proSecOver[2][10]}</td>
								<td>${proSecOver[2][11]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[0].count eq 0 ? 0 : proSecOver[2][0]/scnCountListCorn[0].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[1].count eq 0 ? 0 : proSecOver[2][1]/scnCountListCorn[1].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[2].count eq 0 ? 0 : proSecOver[2][2]/scnCountListCorn[2].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[3].count eq 0 ? 0 : proSecOver[2][3]/scnCountListCorn[3].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[4].count eq 0 ? 0 : proSecOver[2][4]/scnCountListCorn[4].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[5].count eq 0 ? 0 : proSecOver[2][5]/scnCountListCorn[5].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[6].count eq 0 ? 0 : proSecOver[2][6]/scnCountListCorn[6].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[7].count eq 0 ? 0 : proSecOver[2][7]/scnCountListCorn[7].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[8].count eq 0 ? 0 : proSecOver[2][8]/scnCountListCorn[8].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[9].count eq 0 ? 0 : proSecOver[2][9]/scnCountListCorn[9].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[10].count eq 0 ? 0 : proSecOver[2][10]/scnCountListCorn[10].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListCorn[11].count eq 0 ? 0 : proSecOver[2][11]/scnCountListCorn[11].count*100}" maxFractionDigits="2" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>蔬菜类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>蔬菜类采样点</td>
								<td>${scnCountListVegetables[0].count}</td>
								<td>${scnCountListVegetables[1].count}</td>
								<td>${scnCountListVegetables[2].count}</td>
								<td>${scnCountListVegetables[3].count}</td>
								<td>${scnCountListVegetables[4].count}</td>
								<td>${scnCountListVegetables[5].count}</td>
								<td>${scnCountListVegetables[6].count}</td>
								<td>${scnCountListVegetables[7].count}</td>
								<td>${scnCountListVegetables[8].count}</td>
								<td>${scnCountListVegetables[9].count}</td>
								<td>${scnCountListVegetables[10].count}</td>
								<td>${scnCountListVegetables[11].count}</td>
							</tr>
							<tr>
								<td>蔬菜类超标点</td>
								<td>${proSecOver[3][0]}</td>
								<td>${proSecOver[3][1]}</td>
								<td>${proSecOver[3][2]}</td>
								<td>${proSecOver[3][3]}</td>
								<td>${proSecOver[3][4]}</td>
								<td>${proSecOver[3][5]}</td>
								<td>${proSecOver[3][6]}</td>
								<td>${proSecOver[3][7]}</td>
								<td>${proSecOver[3][8]}</td>
								<td>${proSecOver[3][9]}</td>
								<td>${proSecOver[3][10]}</td>
								<td>${proSecOver[3][11]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[0].count eq 0 ? 0 : proSecOver[3][0]/scnCountListVegetables[0].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[1].count eq 0 ? 0 : proSecOver[3][1]/scnCountListVegetables[1].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[2].count eq 0 ? 0 : proSecOver[3][2]/scnCountListVegetables[2].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[3].count eq 0 ? 0 : proSecOver[3][3]/scnCountListVegetables[3].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[4].count eq 0 ? 0 : proSecOver[3][4]/scnCountListVegetables[4].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[5].count eq 0 ? 0 : proSecOver[3][5]/scnCountListVegetables[5].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[6].count eq 0 ? 0 : proSecOver[3][6]/scnCountListVegetables[6].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[7].count eq 0 ? 0 : proSecOver[3][7]/scnCountListVegetables[7].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[8].count eq 0 ? 0 : proSecOver[3][8]/scnCountListVegetables[8].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[9].count eq 0 ? 0 : proSecOver[3][9]/scnCountListVegetables[9].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[10].count eq 0 ? 0 : proSecOver[3][10]/scnCountListVegetables[10].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListVegetables[11].count eq 0 ? 0 : proSecOver[3][11]/scnCountListVegetables[11].count*100}" maxFractionDigits="2" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>其他类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>其他类采样点</td>
								<td>${scnCountListOther[0].count}</td>
								<td>${scnCountListOther[1].count}</td>
								<td>${scnCountListOther[2].count}</td>
								<td>${scnCountListOther[3].count}</td>
								<td>${scnCountListOther[4].count}</td>
								<td>${scnCountListOther[5].count}</td>
								<td>${scnCountListOther[6].count}</td>
								<td>${scnCountListOther[7].count}</td>
								<td>${scnCountListOther[8].count}</td>
								<td>${scnCountListOther[9].count}</td>
								<td>${scnCountListOther[10].count}</td>
								<td>${scnCountListOther[11].count}</td>
							</tr>
							<tr>
								<td>其他类超标点</td>
								<td>${proSecOver[4][0]}</td>
								<td>${proSecOver[4][1]}</td>
								<td>${proSecOver[4][2]}</td>
								<td>${proSecOver[4][3]}</td>
								<td>${proSecOver[4][4]}</td>
								<td>${proSecOver[4][5]}</td>
								<td>${proSecOver[4][6]}</td>
								<td>${proSecOver[4][7]}</td>
								<td>${proSecOver[4][8]}</td>
								<td>${proSecOver[4][9]}</td>
								<td>${proSecOver[4][10]}</td>
								<td>${proSecOver[4][11]}</td>
							</tr>
							<tr>
								<td>超标率（%）</td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[0].count eq 0 ? 0 : proSecOver[4][0]/scnCountListOther[0].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[1].count eq 0 ? 0 : proSecOver[4][1]/scnCountListOther[1].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[2].count eq 0 ? 0 : proSecOver[4][2]/scnCountListOther[2].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[3].count eq 0 ? 0 : proSecOver[4][3]/scnCountListOther[3].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[4].count eq 0 ? 0 : proSecOver[4][4]/scnCountListOther[4].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[5].count eq 0 ? 0 : proSecOver[4][5]/scnCountListOther[5].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[6].count eq 0 ? 0 : proSecOver[4][6]/scnCountListOther[6].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[7].count eq 0 ? 0 : proSecOver[4][7]/scnCountListOther[7].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[8].count eq 0 ? 0 : proSecOver[4][8]/scnCountListOther[8].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[9].count eq 0 ? 0 : proSecOver[4][9]/scnCountListOther[9].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[10].count eq 0 ? 0 : proSecOver[4][10]/scnCountListOther[10].count*100}" maxFractionDigits="2" /></td>
								<td><fmt:formatNumber type="number" value="${scnCountListOther[11].count eq 0 ? 0 : proSecOver[4][11]/scnCountListOther[11].count*100}" maxFractionDigits="2" /></td>
								
							</tr>
						</table><br>
					</div>
				</div>
			</div>
			
			
			
			
			
			<!-- 图11. 各类农产品重金属浓度平均超标倍数情况 -->
			<div class="container">
				<div class="contitle">各类农产品重金属浓度平均超标倍数情况</div>
				<div style="width: 100%;height: 800px;margin-left: 10px;">
					 <div style="margin-left: 20px;width:100%;height: 230px;">
						
						<table style="text-align: left;float: left;">
							<tr>
								<th></th>
								
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>小麦</td>
								
								<td>${avgMulti[0][0]}</td>
								<td>${avgMulti[0][1]}</td>
								<td>${avgMulti[0][2]}</td>
								<td>${avgMulti[0][3]}</td>
								<td>${avgMulti[0][4]}</td>	
							</tr>
							<tr>
								<td>水稻</td>
								
								<td>${avgMulti[1][0]}</td>
								<td>${avgMulti[1][1]}</td>
								<td>${avgMulti[1][2]}</td>
								<td>${avgMulti[1][3]}</td>
								<td>${avgMulti[1][4]}</td>
								
							</tr>
							<tr>
								<td>玉米</td>
								
								<td>${avgMulti[2][0]}</td>
								<td>${avgMulti[2][1]}</td>
								<td>${avgMulti[2][2]}</td>
								<td>${avgMulti[2][3]}</td>
								<td>${avgMulti[2][4]}</td>
								
							</tr>
							<tr>
								<td>蔬菜</td>
								
								<td>${avgMulti[3][0]}</td>
								<td>${avgMulti[3][1]}</td>
								<td>${avgMulti[3][2]}</td>
								<td>${avgMulti[3][3]}</td>
								<td>${avgMulti[3][4]}</td>
								
							</tr>
							<tr>
								<td>其他</td>
								
								<td>${avgMulti[4][0]}</td>
								<td>${avgMulti[4][1]}</td>
								<td>${avgMulti[4][2]}</td>
								<td>${avgMulti[4][3]}</td>
								<td>${avgMulti[4][4]}</td>
								
							</tr>
							
							
						</table>
					</div>
					<div id="main11-1" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main11-2" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main11-3" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main11-4" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
					<div id="main11-5" style="width: 300px;height:260px;float: left;margin-left: 20px;"></div>
							
				</div>
				
			</div>	 
			
			
			
			<!-- 表20.	不同农产品污染风险等级点位分布情况 -->
			<div class="container">
				<div class="contitle">表20.	不同农产品污染风险等级点位分布情况</div>
				<div style="width: 100%;height: 900px;margin-left: 10px;">
					 <div style="margin-left: 20px;width:100%;height: 230px;">
						
						<table style="text-align: left;float: left;">
							<tr>
								<th></th>
								<th style="width:80px;">一级产品</th>
								<th style="width:80px;">二级产品</th>
								<th style="width:80px;">三级产品</th>
								
							</tr>
							<tr>
								<td>小麦</td>
								<td>${proClassGrade[0][0]}</td>
								<td>${proClassGrade[0][1]}</td>
								<td>${proClassGrade[0][2]}</td>
							</tr>
							<tr>
								<td>水稻</td>
							
								<td>${proClassGrade[1][0]}</td>
								<td>${proClassGrade[1][1]}</td>
								<td>${proClassGrade[1][2]}</td>
								
								
							</tr>
							<tr>
								<td>玉米</td>
								
								<td>${proClassGrade[2][0]}</td>
								<td>${proClassGrade[2][1]}</td>
								<td>${proClassGrade[2][2]}</td>
							
								
							</tr>
							<tr>
								<td>蔬菜</td>
								
								<td>${proClassGrade[3][0]}</td>
								<td>${proClassGrade[3][1]}</td>
								<td>${proClassGrade[3][2]}</td>
								
								
							</tr>
							<tr>
								<td>其他</td>
							
								<td>${proClassGrade[4][0]}</td>
								<td>${proClassGrade[4][1]}</td>
								<td>${proClassGrade[4][2]}</td>
			
							</tr>
			
						</table>
					</div>
					<div id="main12-1" style="width: 330px;height:330px;float: left;margin-left: 60px;"></div>
					<div id="main12-2" style="width: 330px;height:330px;float: left;margin-left: 60px;"></div>
					<div id="main12-3" style="width: 330px;height:330px;float: left;margin-left: 60px;"></div>
					<div id="main12-4" style="width: 330px;height:330px;float: left;margin-left: 60px;"></div>
					<div id="main12-5" style="width: 330px;height:330px;float: left;margin-left: 60px;"></div>
							
				</div>
			</div>	 
			
			
			
			<!-- 表21.	天津市行政区县小麦类农产品重金属污染风险点位分布 -->
			<div class="container">
				<div class="contitle">表21.	天津市行政区县小麦类农产品重金属污染风险点位分布</div>
				<div style="width: 100%;height: 800px;margin-left: 10px;">
				<div style="float: left;margin-left: 20px;">
						<p>小麦类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>一级产品</td>
								<td>${proSecGrade[0][0][0]}</td>
								<td>${proSecGrade[0][1][0]}</td>
								<td>${proSecGrade[0][2][0]}</td>
								<td>${proSecGrade[0][3][0]}</td>
								<td>${proSecGrade[0][4][0]}</td>
								<td>${proSecGrade[0][5][0]}</td>
								<td>${proSecGrade[0][6][0]}</td>
								<td>${proSecGrade[0][7][0]}</td>
								<td>${proSecGrade[0][8][0]}</td>
								<td>${proSecGrade[0][9][0]}</td>
								<td>${proSecGrade[0][10][0]}</td>
								<td>${proSecGrade[0][11][0]}</td>
								
							</tr>
							<tr>
								<td>二级产品</td>
								<td>${proSecGrade[0][0][1]}</td>
								<td>${proSecGrade[0][1][1]}</td>
								<td>${proSecGrade[0][2][1]}</td>
								<td>${proSecGrade[0][3][1]}</td>
								<td>${proSecGrade[0][4][1]}</td>
								<td>${proSecGrade[0][5][1]}</td>
								<td>${proSecGrade[0][6][1]}</td>
								<td>${proSecGrade[0][7][1]}</td>
								<td>${proSecGrade[0][8][1]}</td>
								<td>${proSecGrade[0][9][1]}</td>
								<td>${proSecGrade[0][10][1]}</td>
								<td>${proSecGrade[0][11][1]}</td>
								
							</tr>
							<tr>
								<td>三级产品</td>
								<td>${proSecGrade[0][0][2]}</td>
								<td>${proSecGrade[0][1][2]}</td>
								<td>${proSecGrade[0][2][2]}</td>
								<td>${proSecGrade[0][3][2]}</td>
								<td>${proSecGrade[0][4][2]}</td>
								<td>${proSecGrade[0][5][2]}</td>
								<td>${proSecGrade[0][6][2]}</td>
								<td>${proSecGrade[0][7][2]}</td>
								<td>${proSecGrade[0][8][2]}</td>
								<td>${proSecGrade[0][9][2]}</td>
								<td>${proSecGrade[0][10][2]}</td>
								<td>${proSecGrade[0][11][2]}</td>		
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>水稻类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>一级产品</td>
								<td>${proSecGrade[1][0][0]}</td>
								<td>${proSecGrade[1][1][0]}</td>
								<td>${proSecGrade[1][2][0]}</td>
								<td>${proSecGrade[1][3][0]}</td>
								<td>${proSecGrade[1][4][0]}</td>
								<td>${proSecGrade[1][5][0]}</td>
								<td>${proSecGrade[1][6][0]}</td>
								<td>${proSecGrade[1][7][0]}</td>
								<td>${proSecGrade[1][8][0]}</td>
								<td>${proSecGrade[1][9][0]}</td>
								<td>${proSecGrade[1][10][0]}</td>
								<td>${proSecGrade[1][11][0]}</td>
								
							</tr>
							<tr>
								<td>二级产品</td>
								<td>${proSecGrade[1][0][1]}</td>
								<td>${proSecGrade[1][1][1]}</td>
								<td>${proSecGrade[1][2][1]}</td>
								<td>${proSecGrade[1][3][1]}</td>
								<td>${proSecGrade[1][4][1]}</td>
								<td>${proSecGrade[1][5][1]}</td>
								<td>${proSecGrade[1][6][1]}</td>
								<td>${proSecGrade[1][7][1]}</td>
								<td>${proSecGrade[1][8][1]}</td>
								<td>${proSecGrade[1][9][1]}</td>
								<td>${proSecGrade[1][10][1]}</td>
								<td>${proSecGrade[1][11][1]}</td>
								
							</tr>
							<tr>
								<td>三级产品</td>
								<td>${proSecGrade[1][0][2]}</td>
								<td>${proSecGrade[1][1][2]}</td>
								<td>${proSecGrade[1][2][2]}</td>
								<td>${proSecGrade[1][3][2]}</td>
								<td>${proSecGrade[1][4][2]}</td>
								<td>${proSecGrade[1][5][2]}</td>
								<td>${proSecGrade[1][6][2]}</td>
								<td>${proSecGrade[1][7][2]}</td>
								<td>${proSecGrade[1][8][2]}</td>
								<td>${proSecGrade[1][9][2]}</td>
								<td>${proSecGrade[1][10][2]}</td>
								<td>${proSecGrade[1][11][2]}</td>		
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>玉米类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>一级产品</td>
								<td>${proSecGrade[2][0][0]}</td>
								<td>${proSecGrade[2][1][0]}</td>
								<td>${proSecGrade[2][2][0]}</td>
								<td>${proSecGrade[2][3][0]}</td>
								<td>${proSecGrade[2][4][0]}</td>
								<td>${proSecGrade[2][5][0]}</td>
								<td>${proSecGrade[2][6][0]}</td>
								<td>${proSecGrade[2][7][0]}</td>
								<td>${proSecGrade[2][8][0]}</td>
								<td>${proSecGrade[2][9][0]}</td>
								<td>${proSecGrade[2][10][0]}</td>
								<td>${proSecGrade[2][11][0]}</td>
								
							</tr>
							<tr>
								<td>二级产品</td>
								<td>${proSecGrade[2][0][1]}</td>
								<td>${proSecGrade[2][1][1]}</td>
								<td>${proSecGrade[2][2][1]}</td>
								<td>${proSecGrade[2][3][1]}</td>
								<td>${proSecGrade[2][4][1]}</td>
								<td>${proSecGrade[2][5][1]}</td>
								<td>${proSecGrade[2][6][1]}</td>
								<td>${proSecGrade[2][7][1]}</td>
								<td>${proSecGrade[2][8][1]}</td>
								<td>${proSecGrade[2][9][1]}</td>
								<td>${proSecGrade[2][10][1]}</td>
								<td>${proSecGrade[2][11][1]}</td>
								
							</tr>
							<tr>
								<td>三级产品</td>
								<td>${proSecGrade[2][0][2]}</td>
								<td>${proSecGrade[2][1][2]}</td>
								<td>${proSecGrade[2][2][2]}</td>
								<td>${proSecGrade[2][3][2]}</td>
								<td>${proSecGrade[2][4][2]}</td>
								<td>${proSecGrade[2][5][2]}</td>
								<td>${proSecGrade[2][6][2]}</td>
								<td>${proSecGrade[2][7][2]}</td>
								<td>${proSecGrade[2][8][2]}</td>
								<td>${proSecGrade[2][9][2]}</td>
								<td>${proSecGrade[2][10][2]}</td>
								<td>${proSecGrade[2][11][2]}</td>		
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>蔬菜类</p><br>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>一级产品</td>
								<td>${proSecGrade[3][0][0]}</td>
								<td>${proSecGrade[3][1][0]}</td>
								<td>${proSecGrade[3][2][0]}</td>
								<td>${proSecGrade[3][3][0]}</td>
								<td>${proSecGrade[3][4][0]}</td>
								<td>${proSecGrade[3][5][0]}</td>
								<td>${proSecGrade[3][6][0]}</td>
								<td>${proSecGrade[3][7][0]}</td>
								<td>${proSecGrade[3][8][0]}</td>
								<td>${proSecGrade[3][9][0]}</td>
								<td>${proSecGrade[3][10][0]}</td>
								<td>${proSecGrade[3][11][0]}</td>
								
							</tr>
							<tr>
								<td>二级产品</td>
								<td>${proSecGrade[3][0][1]}</td>
								<td>${proSecGrade[3][1][1]}</td>
								<td>${proSecGrade[3][2][1]}</td>
								<td>${proSecGrade[3][3][1]}</td>
								<td>${proSecGrade[3][4][1]}</td>
								<td>${proSecGrade[3][5][1]}</td>
								<td>${proSecGrade[3][6][1]}</td>
								<td>${proSecGrade[3][7][1]}</td>
								<td>${proSecGrade[3][8][1]}</td>
								<td>${proSecGrade[3][9][1]}</td>
								<td>${proSecGrade[3][10][1]}</td>
								<td>${proSecGrade[3][11][1]}</td>
								
							</tr>
							<tr>
								<td>三级产品</td>
								<td>${proSecGrade[3][0][2]}</td>
								<td>${proSecGrade[3][1][2]}</td>
								<td>${proSecGrade[3][2][2]}</td>
								<td>${proSecGrade[3][3][2]}</td>
								<td>${proSecGrade[3][4][2]}</td>
								<td>${proSecGrade[3][5][2]}</td>
								<td>${proSecGrade[3][6][2]}</td>
								<td>${proSecGrade[3][7][2]}</td>
								<td>${proSecGrade[3][8][2]}</td>
								<td>${proSecGrade[3][9][2]}</td>
								<td>${proSecGrade[3][10][2]}</td>
								<td>${proSecGrade[3][11][2]}</td>		
							</tr>
						</table>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>其他类</p>
						<table>
							<tr>
								<th style="width:100px;"></th>
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
								
							</tr>
							<tr>
								<td>一级产品</td>
								<td>${proSecGrade[4][0][0]}</td>
								<td>${proSecGrade[4][1][0]}</td>
								<td>${proSecGrade[4][2][0]}</td>
								<td>${proSecGrade[4][3][0]}</td>
								<td>${proSecGrade[4][4][0]}</td>
								<td>${proSecGrade[4][5][0]}</td>
								<td>${proSecGrade[4][6][0]}</td>
								<td>${proSecGrade[4][7][0]}</td>
								<td>${proSecGrade[4][8][0]}</td>
								<td>${proSecGrade[4][9][0]}</td>
								<td>${proSecGrade[4][10][0]}</td>
								<td>${proSecGrade[4][11][0]}</td>
								
							</tr>
							<tr>
								<td>二级产品</td>
								<td>${proSecGrade[4][0][1]}</td>
								<td>${proSecGrade[4][1][1]}</td>
								<td>${proSecGrade[4][2][1]}</td>
								<td>${proSecGrade[4][3][1]}</td>
								<td>${proSecGrade[4][4][1]}</td>
								<td>${proSecGrade[4][5][1]}</td>
								<td>${proSecGrade[4][6][1]}</td>
								<td>${proSecGrade[4][7][1]}</td>
								<td>${proSecGrade[4][8][1]}</td>
								<td>${proSecGrade[4][9][1]}</td>
								<td>${proSecGrade[4][10][1]}</td>
								<td>${proSecGrade[4][11][1]}</td>
								
							</tr>
							<tr>
								<td>三级产品</td>
								<td>${proSecGrade[4][0][2]}</td>
								<td>${proSecGrade[4][1][2]}</td>
								<td>${proSecGrade[4][2][2]}</td>
								<td>${proSecGrade[4][3][2]}</td>
								<td>${proSecGrade[4][4][2]}</td>
								<td>${proSecGrade[4][5][2]}</td>
								<td>${proSecGrade[4][6][2]}</td>
								<td>${proSecGrade[4][7][2]}</td>
								<td>${proSecGrade[4][8][2]}</td>
								<td>${proSecGrade[4][9][2]}</td>
								<td>${proSecGrade[4][10][2]}</td>
								<td>${proSecGrade[4][11][2]}</td>		
							</tr>
						</table><br>
					</div>
				
				</div>
			</div>
			
			
			
			
			<!-- 表22.	天津市小麦类受污染农产品重金属污染情况（单位：mg/kg） -->
			<div class="container">
				<div class="contitle">表22.	天津市小麦类受污染农产品重金属污染情况（单位：mg/kg）</div>
				<div style="width: 100%;height: 360px;margin-left: 10px;">
					<div style="float: left;margin-left: 20px;">
						<p>小麦类</p><br>
						<table>
							<tr>
								<th></th>
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>最大值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][0][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][1][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][2][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][3][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][4][0]}" maxFractionDigits="3" /></td>
							</tr>
							<tr>
								<td>最小值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][0][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][1][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][2][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][3][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][4][1]}" maxFractionDigits="3" /></td>
								
							</tr>
							<tr>
								<td>平均值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][0][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][1][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][2][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][3][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[0][4][2]}" maxFractionDigits="3" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>水稻类</p><br>
						<table>
							<tr>
								<th></th>
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>最大值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][0][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][1][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][2][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][3][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][4][0]}" maxFractionDigits="3" /></td>
							</tr>
							<tr>
								<td>最小值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][0][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][1][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][2][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][3][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][4][1]}" maxFractionDigits="3" /></td>
								
							</tr>
							<tr>
								<td>平均值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][0][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][1][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][2][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][3][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[1][4][2]}" maxFractionDigits="3" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>玉米类</p><br>
						<table>
							<tr>
								<th></th>
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>最大值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][0][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][1][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][2][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][3][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][4][0]}" maxFractionDigits="3" /></td>
							</tr>
							<tr>
								<td>最小值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][0][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][1][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][2][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][3][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][4][1]}" maxFractionDigits="3" /></td>
								
							</tr>
							<tr>
								<td>平均值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][0][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][1][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][2][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][3][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[2][4][2]}" maxFractionDigits="3" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>蔬菜类</p><br>
						<table>
							<tr>
								<th></th>
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>最大值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][0][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][1][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][2][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][3][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][4][0]}" maxFractionDigits="3" /></td>
							</tr>
							<tr>
								<td>最小值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][0][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][1][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][2][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][3][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][4][1]}" maxFractionDigits="3" /></td>
								
							</tr>
							<tr>
								<td>平均值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][0][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][1][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][2][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][3][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[3][4][2]}" maxFractionDigits="3" /></td>
								
							</tr>
						</table><br>
					</div>
					<div style="float: left;margin-left: 20px;">
						<p>其他类</p><br>
						<table>
							<tr>
								<th></th>
								<th>As</th>
								<th>Hg</th>
								<th>Pb</th>
								<th>Cd</th>
								<th>Cr</th>
								
							</tr>
							<tr>
								<td>最大值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][0][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][1][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][2][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][3][0]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][4][0]}" maxFractionDigits="3" /></td>
							</tr>
							<tr>
								<td>最小值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][0][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][1][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][2][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][3][1]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][4][1]}" maxFractionDigits="3" /></td>
								
							</tr>
							<tr>
								<td>平均值</td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][0][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][1][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][2][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][3][2]}" maxFractionDigits="3" /></td>
								<td><fmt:formatNumber type="number" value="${proExtreThGrade[4][4][2]}" maxFractionDigits="3" /></td>
								
							</tr>
						</table>
					</div>	
				</div>
			</div>	 
			
			
			
			
			
			
			
			
		<!-- 	<!-- 表14.	天津市农产品产地采样点农产品重金属超标情况 -->
			<script type="text/javascript">
			
			$(function(){
				$.fn.yestop(); 
				var sum='${sum[12]}';
				var over='${productEleOver[5][5]}';
				
				sum = parseFloat(sum);
			    over = parseFloat(over);
			
				var a=over/sum*100;
				var notover=sum-over;
				var c=100-a;
				var d=Math.round(notover/over);
				
				$("#a").html(a.toFixed(2)+"%");
				$("#b").html(notover);
				$("#c").html(c.toFixed(2)+"%");
				$("#d").html(d+":1");
			
				  
				var year='${scnCountListWheat[0].year}';
				if(year!=""){
					
					$("#inityear").val(year);
				}
			}) -->
			
			/**
			 * 超标点位数统计
			 */
			</script>
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			    <script type="text/javascript">
			        // 基于准备好的dom，初始化echarts实例
			        var myChart1 = echarts.init(document.getElementById('main18-1'));
			        var myChart2 = echarts.init(document.getElementById('main18-2'));
			        var myChart3 = echarts.init(document.getElementById('main18-3'));
			        var myChart4 = echarts.init(document.getElementById('main18-4'));
			        var myChart5 = echarts.init(document.getElementById('main18-5'));
			    	var data1=['${productEleOver[0][0]}', '${productEleOver[0][1]}', '${productEleOver[0][2]}', '${productEleOver[0][3]}', '${productEleOver[0][4]}'];
			    	var data2=['${productEleOver[1][0]}', '${productEleOver[1][1]}', '${productEleOver[1][2]}', '${productEleOver[1][3]}', '${productEleOver[1][4]}'];
			    	var data3=['${productEleOver[2][0]}', '${productEleOver[2][1]}', '${productEleOver[2][2]}', '${productEleOver[2][3]}', '${productEleOver[2][4]}'];
			    	var data4=['${productEleOver[3][0]}', '${productEleOver[3][1]}', '${productEleOver[3][2]}', '${productEleOver[3][3]}', '${productEleOver[3][4]}'];
			    	var data5=['${productEleOver[4][0]}', '${productEleOver[4][1]}', '${productEleOver[4][2]}', '${productEleOver[4][3]}', '${productEleOver[4][4]}'];
			        option1 = {
			        		title: {
						        text: '小麦类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data1
			        	        }
			        	    ]
			        	};
			        option2 = {
			        		title: {
						        text: '水稻类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data2
			        	        }
			        	    ]
			        	};
			        option3 = {
			        		title: {
						        text: '玉米类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data3
			        	        }
			        	    ]
			        	};
			        option4 = {
			        		title: {
						        text: '蔬菜类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data4
			        	        }
			        	    ]
			        	};
			        option5 = {
			        		title: {
						        text: '其他类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data5
			        	        }
			        	    ]
			        	};
			
			
			        // 使用刚指定的配置项和数据显示图表。
			        myChart1.setOption(option1);
			        myChart2.setOption(option2);
			        myChart3.setOption(option3);
			        myChart4.setOption(option4);
			        myChart5.setOption(option5);
			    </script>
			
			
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			    <script type="text/javascript">
			        // 基于准备好的dom，初始化echarts实例
			        var myChart1 = echarts.init(document.getElementById('main11-1'));
			        var myChart2 = echarts.init(document.getElementById('main11-2'));
			        var myChart3 = echarts.init(document.getElementById('main11-3'));
			        var myChart4 = echarts.init(document.getElementById('main11-4'));
			        var myChart5 = echarts.init(document.getElementById('main11-5'));
			    	var data1=['${avgMulti[0][0]}', '${avgMulti[0][1]}', '${avgMulti[0][2]}', '${avgMulti[0][3]}', '${avgMulti[0][4]}'];
			    	var data2=['${avgMulti[1][0]}', '${avgMulti[1][1]}', '${avgMulti[1][2]}', '${avgMulti[1][3]}', '${avgMulti[1][4]}'];
			    	var data3=['${avgMulti[2][0]}', '${avgMulti[2][1]}', '${avgMulti[2][2]}', '${avgMulti[2][3]}', '${avgMulti[2][4]}'];
			    	var data4=['${avgMulti[3][0]}', '${avgMulti[3][1]}', '${avgMulti[3][2]}', '${avgMulti[3][3]}', '${avgMulti[3][4]}'];
			    	var data5=['${avgMulti[4][0]}', '${avgMulti[4][1]}', '${avgMulti[4][2]}', '${avgMulti[4][3]}', '${avgMulti[4][4]}'];
			        option1 = {
			        		title: {
						        text: '小麦类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data1
			        	        }
			        	    ]
			        	};
			        option2 = {
			        		title: {
						        text: '水稻类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data2
			        	        }
			        	    ]
			        	};
			        option3 = {
			        		title: {
						        text: '玉米类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data3
			        	        }
			        	    ]
			        	};
			        option4 = {
			        		title: {
						        text: '蔬菜类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data4
			        	        }
			        	    ]
			        	};
			        option5 = {
			        		title: {
						        text: '其他类',
						        subtext: '数量（个）'
						    },
			        		color: ['#3398DB'],
			        	    tooltip : {
			        	        trigger: 'axis',
			        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        	            type : 'line'        // 默认为直线，可选为：'line' | 'shadow'
			        	        }
			        	    },
			        	    grid: {
			        	        left: '3%',
			        	        right: '4%',
			        	        bottom: '3%',
			        	        containLabel: true
			        	    },
			        	    xAxis : [
			        	        {
			        	            type : 'category',
			        	            data : ['As', 'Hg', 'Pb', 'Cd', 'Cr'],
			        	            axisTick: {
			        	                alignWithLabel: true
			        	            }
			        	        }
			        	    ],
			        	    yAxis : [
			        	        {
			        	            type : 'value'
			        	        }
			        	    ],
			        	    series : [
			        	        {
			        	            name:'超标点位数',
			        	            type:'bar',
			        	            barWidth: '40%',
			        	            data:data5
			        	        }
			        	    ]
			        	};
			
			
			        // 使用刚指定的配置项和数据显示图表。
			        myChart1.setOption(option1);
			        myChart2.setOption(option2);
			        myChart3.setOption(option3);
			        myChart4.setOption(option4);
			        myChart5.setOption(option5);
			    </script>
			
			
		
			<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
			    <script type="text/javascript">
			        // 基于准备好的dom，初始化echarts实例
			        var myChart1 = echarts.init(document.getElementById('main12-1'));
			        var myChart2 = echarts.init(document.getElementById('main12-2'));
			        var myChart3 = echarts.init(document.getElementById('main12-3'));
			        var myChart4 = echarts.init(document.getElementById('main12-4'));
			        var myChart5 = echarts.init(document.getElementById('main12-5'));
			    	var data1=['${avgMulti[0][0]}', '${avgMulti[0][1]}', '${avgMulti[0][2]}', '${avgMulti[0][3]}', '${avgMulti[0][4]}'];
			    	var data2=['${avgMulti[1][0]}', '${avgMulti[1][1]}', '${avgMulti[1][2]}', '${avgMulti[1][3]}', '${avgMulti[1][4]}'];
			    	var data3=['${avgMulti[2][0]}', '${avgMulti[2][1]}', '${avgMulti[2][2]}', '${avgMulti[2][3]}', '${avgMulti[2][4]}'];
			    	var data4=['${avgMulti[3][0]}', '${avgMulti[3][1]}', '${avgMulti[3][2]}', '${avgMulti[3][3]}', '${avgMulti[3][4]}'];
			    	var data5=['${avgMulti[4][0]}', '${avgMulti[4][1]}', '${avgMulti[4][2]}', '${avgMulti[4][3]}', '${avgMulti[4][4]}'];
			    	option1 = {
			    		    title : {
			    		        text: '小麦类',
			    		        subtext: '',
			    		        x:'center'
			    		    },
			    		    tooltip : {
			    		        trigger: 'item',
			    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    		    },
			    		    legend: {
			    		        orient: 'vertical',
			    		        left: 'left',
			    		        data: ['一级产品','二级产品','三级产品']
			    		    },
			    		    series : [
			    		        {
			    		            name: '污染点占比',
			    		            type: 'pie',
			    		            radius : '55%',
			    		            center: ['50%', '60%'],
			    		            color: ['#1E90FF', '#FF6347', '#9C9C9C'],
			    		            data:[
			    		                {value:'${proClassGrade[0][0]}', name:'一级产品'},
			    		                {value:'${proClassGrade[0][1]}', name:'二级产品'},
			    		                {value:'${proClassGrade[0][2]}', name:'三级产品'},
			    		             
			    		            ],
			    		            itemStyle: {
			    		                emphasis: {
			    		                    shadowBlur: 10,
			    		                    shadowOffsetX: 0,
			    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			    		                }
			    		            }
			    		        }
			    		    ]
			    		};
			
			        option2 = {
			    		    title : {
			    		        text: '水稻类',
			    		        subtext: '',
			    		        x:'center'
			    		    },
			    		    tooltip : {
			    		        trigger: 'item',
			    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    		    },
			    		    legend: {
			    		        orient: 'vertical',
			    		        left: 'left',
			    		        data: ['一级产品','二级产品','三级产品']
			    		    },
			    		    series : [
			    		        {
			    		            name: '污染点占比',
			    		            type: 'pie',
			    		            radius : '55%',
			    		            center: ['50%', '60%'],
			    		            color: ['#1E90FF', '#FF6347', '#9C9C9C'],
			    		            data:[
			    		                {value:'${proClassGrade[1][0]}', name:'一级产品'},
			    		                {value:'${proClassGrade[1][1]}', name:'二级产品'},
			    		                {value:'${proClassGrade[1][2]}', name:'三级产品'},
			    		             
			    		            ],
			    		            itemStyle: {
			    		                emphasis: {
			    		                    shadowBlur: 10,
			    		                    shadowOffsetX: 0,
			    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			    		                }
			    		            }
			    		        }
			    		    ]
			    		};
			        option3 = {
			    		    title : {
			    		        text: '玉米类',
			    		        subtext: '',
			    		        x:'center'
			    		    },
			    		    tooltip : {
			    		        trigger: 'item',
			    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    		    },
			    		    legend: {
			    		        orient: 'vertical',
			    		        left: 'left',
			    		        data: ['一级产品','二级产品','三级产品']
			    		    },
			    		    series : [
			    		        {
			    		            name: '污染点占比',
			    		            type: 'pie',
			    		            radius : '55%',
			    		            center: ['50%', '60%'],
			    		            color: ['#1E90FF', '#FF6347', '#9C9C9C'],
			    		            data:[
			    		                {value:'${proClassGrade[2][0]}', name:'一级产品'},
			    		                {value:'${proClassGrade[2][1]}', name:'二级产品'},
			    		                {value:'${proClassGrade[2][2]}', name:'三级产品'},
			    		             
			    		            ],
			    		            itemStyle: {
			    		                emphasis: {
			    		                    shadowBlur: 10,
			    		                    shadowOffsetX: 0,
			    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			    		                }
			    		            }
			    		        }
			    		    ]
			    		};
			        option4 = {
			    		    title : {
			    		        text: '蔬菜类',
			    		        subtext: '',
			    		        x:'center'
			    		    },
			    		    tooltip : {
			    		        trigger: 'item',
			    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    		    },
			    		    legend: {
			    		        orient: 'vertical',
			    		        left: 'left',
			    		        data: ['一级产品','二级产品','三级产品']
			    		    },
			    		    series : [
			    		        {
			    		            name: '污染点占比',
			    		            type: 'pie',
			    		            radius : '55%',
			    		            center: ['50%', '60%'],
			    		            color: ['#1E90FF', '#FF6347', '#9C9C9C'],
			    		            data:[
			    		                {value:'${proClassGrade[3][0]}', name:'一级产品'},
			    		                {value:'${proClassGrade[3][1]}', name:'二级产品'},
			    		                {value:'${proClassGrade[3][2]}', name:'三级产品'},
			    		             
			    		            ],
			    		            itemStyle: {
			    		                emphasis: {
			    		                    shadowBlur: 10,
			    		                    shadowOffsetX: 0,
			    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			    		                }
			    		            }
			    		        }
			    		    ]
			    		};
			        option5 = {
			    		    title : {
			    		        text: '其他类',
			    		        subtext: '',
			    		        x:'center'
			    		    },
			    		    tooltip : {
			    		        trigger: 'item',
			    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    		    },
			    		    legend: {
			    		        orient: 'vertical',
			    		        left: 'left',
			    		        data: ['一级产品','二级产品','三级产品']
			    		    },
			    		    series : [
			    		        {
			    		            name: '污染点占比',
			    		            type: 'pie',
			    		            radius : '55%',
			    		            center: ['50%', '60%'],
			    		            color: ['#1E90FF', '#FF6347', '#9C9C9C'],
			    		            data:[
			    		                {value:'${proClassGrade[4][0]}', name:'一级产品'},
			    		                {value:'${proClassGrade[4][1]}', name:'二级产品'},
			    		                {value:'${proClassGrade[4][2]}', name:'三级产品'},
			    		             
			    		            ],
			    		            itemStyle: {
			    		                emphasis: {
			    		                    shadowBlur: 10,
			    		                    shadowOffsetX: 0,
			    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			    		                }
			    		            }
			    		        }
			    		    ]
			    		};
			
			
			        // 使用刚指定的配置项和数据显示图表。
			        myChart1.setOption(option1);
			        myChart2.setOption(option2);
			        myChart3.setOption(option3);
			        myChart4.setOption(option4);
			        myChart5.setOption(option5);
			    </script>
		</div>
	</section>

</body>
</html>