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
                    var tdText = $(this).html();
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
 
    </script>

</head>
<body class="dashboard-page">
	<nav class="main-menu">
	<ul>
		<li><a href="${APP_PATH}/index.jsp"> <i class="fa fa-home nav_icon"></i> <span
				class="nav-text"> 主页 </span>
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
		<li class="has-subnav">
			<a href="${APP_PATH}/input.jsp"> 
				<i class="fa fa-file-text-o nav_icon"></i> <span class="nav-text"> 文件导入</span>
			</a>
		</li>
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
		<li><a href="/SoilenvironmentMana/user/outLogin"> <i class="icon-off nav-icon"></i> <span
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
				<h1>
					<a href="#"><img src="images/logo.png" alt="" />天津市农产品产地土壤重金属</a>
				</h1>
			</div>
			<div class="header-right" style="margin-right: 50px;">
				<div class="profile_details_left">
					<div class="profile_img" style="position: absolute;">	
							<span class="prfil-img"><i class="fa fa-user" aria-hidden="true"></i></span> 
							<div class="clearfix"></div>	
					</div>	
					<div style="float:right;margin-left: 50px;margin-top: 5px;font-size:150%"><b>当前用户：${user.username}，
						<a href="/SoilenvironmentMana/user/outLogin" style="text-decoration: none;color: #90EE90;">注销</a></b>
					</div>
					<div class="clearfix"> </div>
				</div>
		 	</div>
			<div class="clearfix"></div>	
		</section> 
		<div class="main-grid">
				<input type="button" value="新增" id="add">
<input type="button" value="删除最后一行" id="delete">
<input type="button" value="删除选中的一行" id="deleteone">
<table border="1">
    <thead>
    <tr>
        <th colspan="4">编辑表格</th>
    </tr>
    </thead>
 
    <tr>
        <th><input type="checkbox" id="cha"></th>
        <th>学号</th>
        <th>姓名</th>
        <th>操作</th>
    </tr>
    <tr>
        <td><input type="checkbox"></td>
        <td>000001</td>
        <td>张三</td>
        <td >
            <input type="button" value="编辑" >
            <input type="button" value="确定" >
        </td>
    </tr>
    <tr>
        <td><input type="checkbox"></td>
        <td>000002</td>
        <td>李四</td>
        <td>
            <input type="button" value="编辑" >
            <input type="button" value="确定" >
        </td>
    </tr>
    <tr>
        <td><input type="checkbox"></td>
        <td>000003</td>
        <td>王五</td>
        <td>
            <input type="button" value="编辑" >
            <input type="button" value="确定" >
        </td>
    </tr>
    <tr>
        <td><input type="checkbox"></td>
        <td>000004</td>
        <td>赵六</td>
        <td>
            <input type="button" value="编辑" >
            <input type="button" value="确定" >
        </td>
    </tr>
 
</table>
		</div>
	</section>
</body>
</html>