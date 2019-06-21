$(function() {
	// 获取当前网址，如： http://localhost:80/ybzx/index.jsp  
	var curPath = window.document.location.href;
	// 获取主机地址之后的目录，如： ybzx/index.jsp  
	var pathName = window.document.location.pathname;
	var pos = curPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:80  
	var localhostPaht = curPath.substring(0, pos);
	// 获取项目名，如：index
	var jspName = pathName.substring(pathName.substr(1).indexOf('/') + 2,
			pathName.substr(1).indexOf('.') + 1);
	// 获取带"/"的项目名，如：/ybzx
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);
	var pageName = pathName.substring(pathName.lastIndexOf("/") + 1);

	$('#kindofanal').submit(function() {
		var way = document.getElementById("ways").value;
		$.ajax({
			url : projectName + '/changestandard/selectStandard',
			type : "POST",
			data : "way=" + way,
			dataType : 'json',
			async : false,
			success : function(data) {
				drawtable1(way, data.object.ranges, data.object.result);
			}
		})
	});

	function drawtable1(name, ranges, result) {
		var html = '';
		var title = '';
		var num = 0;
		var percent = 1 / (ranges.length + 3);
		if (name == "overproof") {
			title = '安全评估筛选值';
		} else if (name == "securelevel") {
			title = '安全等级筛选值';
		} else if (name == "pollutionlevel") {
			title = '污染风险筛选值';
		}
		html += '<tr><td colspan="2" rowspan="2" width="' + percent + '">污染物项目</td>';
		html += '<td colspan="' + ranges.length + '" width="' + percent * ranges.length + '">' + title + '</td>';
		html += '<td rowspan="2">操作</td></tr><tr>';
		for (i in ranges) {
			html += '<td width="' + percent + '">' + ranges[i] + '</td>';
		}
		html += '</tr>';
		for (var i = 0; i < result.length / (2 + ranges.length); i++) {
			//根据是否是有两种标准进行划分
			if (result[i * (2 + ranges.length)] == result[(i + 1)	* (2 + ranges.length)]){
				html += '<tr><td rowspan="2">'+result[i * (2 + ranges.length)]+'</td>';
				html += '<td width="'+percent / 2+'">'+result[i * (2 + ranges.length) + 1]+'</td>';
				for(var j = 0; j < ranges.length; j++){
					html += '<td   width="'+percent+'">'+result[i * (2 + ranges.length) + 2 + j]+'</td>';
				}
				html += '<td><input type="button" value="编辑"> <input type="button" value="确定"></td>';
				html += '</tr><tr><td width="'+percent / 2+'">'+result[(i + 1) * (2 + ranges.length) + 1]+'</td>';
				for(var j = 0; j < ranges.length; j++){
					html += '<td   width="'+percent+'">'+result[(i + 1) * (2 + ranges.length) + 2 + j]+'</td>';
				}
				html += '<td><input type="button" value="编辑"> <input type="button" value="确定"></td>';
				i++;
			}else{
				html += '<tr><td colspan="2"  width="'+percent+'">'+result[i * (2 + ranges.length)]+'</td>';
				for(var j = 0; j < ranges.length; j++){
					html += '<td   width="'+percent+'">'+result[i * (2 + ranges.length) + 2 + j]+'</td>';
				}
				html += '<td><input type="button" value="编辑"> <input type="button" value="确定"></td>';
			}
			html += '</tr>';
		}
		$("#standardshow").html(html);
	}
})