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
<script type="text/javascript">
		function AddTableRow()
		{
    		<span style="white-space:pre">	</span>var Table = document.getElementById("tab");   //取得自定义的表对象
    		<span style="white-space:pre">	</span>NewRow = Table.insertRow();                        //添加行
    		<span style="white-space:pre">	</span>NewCell1= NewRow.insertCell();                     //添加列
			NewCell2=NewRow.insertCell();
			NewCell1.innerHTML = "<B>这是新加的列</B>";          //添加数据
			NewCell1.innerHTML="<a href='#'>这是空链接</a>";
		}			 
	</script>

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
	</section> <!--按钮的代码-->
<div style="overflow: auto; height: 350px; width: 860px; padding: 10px;">
        <table cellpadding="1" id="tab" cellspacing="0" bordercolor="#A3C0E8" border="1"
            style="text-align: center">
            <tr id="tr1">
                <td></td>
                <td> </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr id="trHeader">
                <td style="background: #D3E6FE">NO</td>
                <td style="background: #D3E6FE">试验项目</td>
                <td style="background: #D3E6FE">检验项目</td>
                <td style="background: #D3E6FE">标准</td>
                <td style="background: #D3E6FE">1</td>
            </tr>
            <tr>
                <td>1</td>
                <td><input id='textItem0' type='text' style="border: 0px" size='12' /></td>
                <td><input id='checkItem0' type='text' style="border: 0px" size='12' /></td>
                <td><input id='stand0' type='text' style="border: 0px" size='12' /></td>
                <td><textarea rows="4" id="" style="width: 150px; height: 40px;"></textarea></td>
            </tr>
        </table>
        <table cellpadding="1" cellspacing="0" bordercolor="#A3C0E8" border="1" style="text-align: center">
            <tr>
                <td style="background: #D3E6FE"> </td>
                <td style="background: #D3E6FE">
                    <input type="button" name="Submit" value="新增行" onclick="AddNewRow()" />
                </td>
                <td style="background: #D3E6FE">
                    <input type="button" name="Submit" value="新增列" onclick="AddNewColumn()" />
                </td>
                <td style="background: #D3E6FE">
                    <input type="button" name="Submit2" value="全部清空" onclick="ClearAllSign()" />
                </td>
                <td style="background: #D3E6FE">
                    <input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex' value="1" />
                    <input name='txtTDLastIndex' type='hidden' id='txtTDLastIndex' value="4" />
                </td>
            </tr>
        </table>
    </div>
	</section>
</body>
<script language="javascript" type="text/javascript">
 
        function findObj(theObj, theDoc) {
            var p, i, foundObj;
            if (!theDoc) theDoc = document;
            if ((p = theObj.indexOf("?")) > 0 && parent.frames.length) {
                theDoc = parent.frames[theObj.substring(p + 1)].document; 
                theObj = theObj.substring(0, p);
            }
            if (!(foundObj = theDoc[theObj]) && theDoc.all)  foundObj = theDoc.all[theObj]; 
            for (i = 0; !foundObj && i < theDoc.forms.length; i++) 
            	foundObj = theDoc.forms[i][theObj]; 
            for (i = 0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
            	foundObj = findObj(theObj, theDoc.layers[i].document);
            if (!foundObj && document.getElementById)
                foundObj = document.getElementById(theObj); 
            return foundObj;
        }
 
        //添加一个列
        count = 1;
        function AddNewColumn() {
            var txtTDLastIndex = findObj("txtTDLastIndex", document);
            var columnID = parseInt(txtTDLastIndex.value);
 
            var tab = document.getElementById("tab");
            var rowLength = tab.rows.length;
            var columnLength = tab.rows[1].cells.length;
 
            for (var i = 0; i < rowLength; i++) {
                if (i == 0) {
                    var oTd = tab.rows[0].insertCell(columnLength);
                    oTd.innerHTML = "<div align='center' style='width:40px'><a href='javascript:' onclick=\"DeleteSignColumn(" + (++columnID) + ")\">删除</a></div>";
                } else if (i == 1) {//第一列:序号
                    var oTd = tab.rows[1].insertCell(columnLength);
                    oTd.innerHTML = "<div style='background: #D3E6FE;width=100%;'>" + (++count) + "</div>";
                } else if (i > 1) {
                    var oTd = tab.rows[i].insertCell(columnLength);
                    oTd.id = "column" + columnID;
                    oTd.innerHTML = "<textarea id=''  rows='4' style='width:150; height:40px;'></textarea>";
                }
            }
 
        }
 
        //添加一个行
        var index = 1;
        function AddNewRow() {
            var txtTRLastIndex = findObj("txtTRLastIndex", document);
            var rowID = parseInt(txtTRLastIndex.value);
 
            var tab = findObj("tab", document);
            var columnLength = tab.rows[0].cells.length;
 
            //添加行
            var newTR = tab.insertRow(tab.rows.length);
            newTR.id = "SignItem" + rowID;
 
            for (var i = 0; i < columnLength; i++) {
                if (i == 0) {//第一列:序号
                    newTR.insertCell(0).innerHTML = ++index;
                } else if (i > 0 && i < 4) {
                    newTR.insertCell(i).innerHTML = "<input id='textItem0' type='text' style='border: 0px' size='12' />";
                }
                else if (i >= 4) {
                    newTR.insertCell(i).innerHTML = "<textarea id=''  rows='4' style='width:150; height:40px;'></textarea>";
                }
            }
 
            //添加列:删除按钮
            var lastTd = newTR.insertCell(columnLength);
            lastTd.innerHTML = "<div align='center' style='width:40px'><a href='javascript:' onclick=\"DeleteSignRow('SignItem" + rowID + "')\">删除</a></div>";
 
            //将行号推进下一行
            txtTRLastIndex.value = (rowID + 1).toString();
        }
 
        //删除指定行
        function DeleteSignRow(rowid) {
            var tab = findObj("tab", document);
            var signItem = findObj(rowid, document);
 
            //获取将要删除的行的Index
            var rowIndex = signItem.rowIndex;
 
            //删除指定Index的行
            tab.deleteRow(rowIndex);
 
 
            //重新排列序号，如果没有序号，这一步省略
            for (i = 2; i < tab.rows.length; i++) {
                tab.rows[i].cells[0].innerHTML = i - 1;
            }
 
            --index
        }
 
        //删除指定列
        function DeleteSignColumn(columnId) {
            var tab = document.getElementById("tab");
            var columnLength = tab.rows[1].cells.length;
 
            //删除指定单元格 
            for (var i = 0; i < tab.rows.length; i++) {
                tab.rows[i].deleteCell(columnId);
            }
 
            //重新排列序号，如果没有序号，这一步省略
            var column = columnLength - 4;
 
            for (var j = 1; j < column; j++) {
                tab.rows[1].cells[j + 3].innerHTML = "<div style='background: #D3E6FE;width=100%;'>" + j + "</div>";
            }
 
            --count;
        }
 
 
        //清空列表
        function ClearAllSign() {
            //if (confirm('确定要清空所有吗？')) {
            index = 0;
            var tab = findObj("tab", document);
            var rowscount = tab.rows.length;
 
            //循环删除行,从最后一行往前删除
            for (i = rowscount - 1; i > 1; i--) {
                tab.deleteRow(i);
            }
 
            //重置最后行号为1
            var txtTRLastIndex = findObj("txtTRLastIndex", document);
            txtTRLastIndex.value = "1";
 
            //预添加一行
            AddNewRow();
        }
    </script>
</html>