<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>开始</title>
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

<script>
        //文档准备就绪
        $(function () {
            //设置 所有 td 居中
            $('table td').attr("align","center");
            //标签+属性选择所有<编辑>按钮
            $('input[value="编辑"]').click(function () {
            	var re = /^[0-9]+.?[0-9]*$/; //判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/ 
                //获取每一个<编辑>按钮的 下标（从0开始 所以需要+2 = 按钮在表格的所在行数）
                var numId = $('input[value="编辑"]').index($(this))+2;
                //选择表格中的所有tr 通过eq方法取得当前tr
                var ttr = $('table tr').eq(numId);
                /*当前行使用find方法找到每一个td列
                 each方法为每一个td设置function
                 */
                ttr.find("td").each(function () {
                    /*过滤 td中的元素
                     checkbox 、 button、text 不需要执行append
                     注意 return 为 跳出当前 each
                     return false 为 跳出整个 each
                     */
                    if($(this).children("input[type='checkbox']").length>0){
                        return ;
                    }
                    if($(this).children("input[type='button']").length>0){
                        return ;
                    }
                    if($(this).children("input[type='text']").length>0){
                        return ;
                    }
                    var tdText = $(this).html().trim();
                    if(!re.test(tdText)){
                        return ;
                    }
                    $(this).html("");
                    var inputObj = $("<input type='text'>");
                    inputObj.appendTo($(this));
                    inputObj.css("width","95%");
                    inputObj.val(tdText);
                });
            });
            //为每一个确定按钮设置点击事件
            $('input[value="确定"]').click(function () {
                /*通过parents方法获取<确定>按钮的父容器tr
                 再为 tr中的每一个text设置function
                 */
                var ttr=$(this).parents("tr");
                ttr.find('input[type="text"]').each(function () {
                    var inputVal = $(this).val();
                    $(this).parents('td').html(inputVal);
                })
            });
            //全选/反选
            $('#cha').click(function () {
                //判断checkbox是否选中
                if($(this).is(':checked')){
                    $('input[type="checkbox"]').attr("checked","true");
                }else{
                    $('input[type="checkbox"]').removeAttr("checked");
                }
            });
            //增加一行
            $('#add').click(function () {
                $('table tr').eq(2).clone(true).appendTo("table");
            });
            //删除最后一行
            $('#delete').click(function () {
                $('table tr:last').remove();
            });
            $('#deleteone').click(function () {
                $('input[type="checkbox"]');
 
            });
            
            
        })

	function hahha() {
        	var standards=new Array();
        	var re = /^[0-9]+.?[0-9]*$/; 
        	$('#showtable').find("input[value='编辑']").each(function () {
        		 var numId = $('input[value="编辑"]').index($(this))+2;
        		 var ttr = $('table tr').eq(numId);
                 /*当前行使用find方法找到每一个td列
                  each方法为每一个td设置function
                  */
                 ttr.find("td").each(function () {
                     /*过滤 td中的元素
                      checkbox 、 button、text 不需要执行append
                      注意 return 为 跳出当前 each
                      return false 为 跳出整个 each
                      */
                     if($(this).children("input[type='checkbox']").length>0){
                         return ;
                     }
                     if($(this).children("input[type='button']").length>0){
                         return ;
                     }
                     if($(this).children("input[type='text']").length>0){
                         return ;
                     }
                     var tdText = $(this).html().trim();
                     if(!re.test(tdText)){
                         return ;
                         }
                     //alert(tdText);
                     standards.push(tdText);
                 })
        	})
        	var a =0;
        }
</script>

</head>
<body class="dashboard-page">
	<nav class="main-menu">
	<ul>
		<li><a href="${APP_PATH}/index.jsp"> <i
				class="fa fa-home nav_icon"></i> <span class="nav-text"> 主页 </span>
		</a></li>

		<li><a href="${APP_PATH}/tableshow.jsp"> <i
				class="icon-table nav-icon"></i> <span class="nav-text"> 数据查看
			</span>
		</a></li>

		<li><a href="javascript:;"> <i
				class="fa fa-bar-chart nav_icon"></i> <span class="nav-text">
					图表显示 </span><i class="icon-angle-right"></i><i class="icon-angle-down"></i>
		</a>
			<ul>
				<li><a class="subnav-text" href="#">土地重金属含量统计</a></li>
				<li><a class="subnav-text" href="#">土地重金属含量走势</a></li>
				<li><a class="subnav-text" href="#">农作物金属含量统计</a></li>
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
				<li><a class="subnav-text" href="#"> 用户信息更改 </a></li>
				<li><a class="subnav-text" href="#"> 用户管理 </a></li>
			</ul></li>
	</ul>
	<ul class="logout">
		<li><a href="/SoilenvironmentMana/user/outLogin"> <i
				class="icon-off nav-icon"></i> <span class="nav-text"> 注销 </span>
		</a></li>
	</ul>
	</nav>
	<section class="wrapper scrollable"> <nav class="user-menu">
	<a href="javascript:;" class="main-menu-access"> <i
		class="icon-proton-logo"></i> <i class="icon-reorder"></i>
	</a> </nav> <section class="title-bar">
	<div class="logo" style="width: 70%">
		<h1>
			<a href="#"><img src="images/logo.png" alt="" />天津市农产品产地土壤重金属</a>
		</h1>
	</div>
	<div class="header-right" style="margin-right: 50px;">
		<div class="profile_details_left">
			<div class="profile_img" style="position: absolute;">
				<span class="prfil-img"><i class="fa fa-user"
					aria-hidden="true"></i></span>
				<div class="clearfix"></div>
			</div>
			<div
				style="float: right; margin-left: 50px; margin-top: 5px; font-size: 150%">
				<b>当前用户：${user.username}， <a
					href="/SoilenvironmentMana/user/outLogin"
					style="text-decoration: none; color: #90EE90;">注销</a></b>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<div class="clearfix"></div>
	</section>
	<div class="main-grid">
		<table id="showtable" border="1" width="1000 " height=600
			" style="margin: auto; text-align: center;">
			<tr>
				<td colspan="2" rowspan="2" width="16% ">污染物项目</td>
				<td colspan="4" width="64% ">风险筛选值</td>
				<td rowspan="2">操作</td>
			</tr>
			<tr>
				<td   width="16% ">pH≤5.5</td>
				<td   width="16% ">5.5＜pH≤6.5</td>
				<td   width="16% ">6.5< pH≤7.5</td>
				<td   width="16% ">pH>7.5</td>
			</tr>
			<tr>
				<td rowspan="2" >镉</td>
				<td width="8% ">水田</td>
				<td  id="a1" width="16% ">0.3</td>
				<td  id="a2" width="16% ">0.4</td>
				<td  id="a3" width="16% ">0.6</td>
				<td  id="a4" width="16% ">0.8</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td id="b1" width="16% ">0.3</td>
				<td id="b2" width="16% ">0.3</td>
				<td id="b3" width="16% ">0.3</td>
				<td id="b4" width="16% ">0.6</td>
				<td><input type="button" value="编辑"> <input type="button" value="确定"></td>
			</tr>
			<tr>
				<td rowspan="2" >汞</td>
				<td   width="8% ">水田</td>
				<td   width="16% ">0.5</td>
				<td   width="16% ">0.5</td>
				<td   width="16% ">0.6</td>
				<td   width="16% ">1.0</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td   width="16% ">1.3</td>
				<td   width="16% ">1.8</td>
				<td   width="16% ">2.4</td>
				<td   width="16% ">3.4</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td rowspan="2" >砷</td>
				<td   width="8% ">水田</td>
				<td   width="16% ">30</td>
				<td   width="16% ">30</td>
				<td   width="16% ">25</td>
				<td   width="16% ">20</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td   width="16% ">40</td>
				<td   width="16% ">40</td>
				<td   width="16% ">30</td>
				<td   width="16% ">25</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td rowspan="2" >铅</td>
				<td   width="8% ">水田</td>
				<td   width="16% ">80</td>
				<td   width="16% ">100</td>
				<td   width="16% ">140</td>
				<td   width="16% ">240</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td   width="16% ">70</td>
				<td   width="16% ">90</td>
				<td   width="16% ">120</td>
				<td   width="16% ">170</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td rowspan="2" >铬</td>
				<td   width="8% ">水田</td>
				<td   width="16% ">250</td>
				<td   width="16% ">250</td>
				<td   width="16% ">300</td>
				<td   width="16% ">350</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td   width="16% ">150</td>
				<td   width="16% ">150</td>
				<td   width="16% ">200</td>
				<td   width="16% ">250</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td rowspan="2" >铜</td>
				<td   width="8% ">果园</td>
				<td   width="16% ">150</td>
				<td   width="16% ">150</td>
				<td   width="16% ">200</td>
				<td   width="16% ">200</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td   width="8% ">其他</td>
				<td   width="16% ">50</td>
				<td   width="16% ">50</td>
				<td   width="16% ">100</td>
				<td   width="16% ">100</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td colspan="2"   width="16% ">镍</td>
				<td   width="16% ">60</td>
				<td   width="16% ">70</td>
				<td   width="16% ">100</td>
				<td   width="16% ">190</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
			<tr>
				<td colspan="2"   width="16% ">锌</td>
				<td   width="16% ">200</td>
				<td   width="16% ">200</td>
				<td   width="16% ">250</td>
				<td   width="16% ">300</td>
				<td><input type="button" value="编辑"> <input
					type="button" value="确定"></td>
			</tr>
		</table>
	</div>
	<div style="margin-left: 90%; margin-top: -50px">
		<input type="button" value="提交" onclick="hahha()">
	</div>
	</section>
</body>
</html>