$(function() {
	// 获取当前网址，如： http://localhost:80/ybzx/index.jsp  
	var curPath = window.document.location.href;
	// 获取主机地址之后的目录，如： ybzx/index.jsp  
	var pathName = window.document.location.pathname;
	var pos = curPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:80  
	var localhostPaht = curPath.substring(0, pos);
	// 获取带"/"的项目名，如：/ybzx
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);

	$(document).ready(function() {
		$.ajax({
			url : projectName + '/init/initData',
			type : "POST",
			dataType : 'json',
			async : false,
			success : function(data) {
				initYear(data.object.years);
				initRegion(data.object.regions);
				initElems(data.object.elements);
				initOthers(data.object.years[0]);
			}
		})
	});

	function initOthers(year){
		var html='<b>'+year;
		var trhtml='<b>';
		var thtml = '';
		var trthtml = '';
		html+='年天津市农产品产地采样点Cd浓度分布情况</b>';
		trhtml+='天津市农产品产地采样点总量趋势图</b>';
		thtml+='<tr><th>超标点数量</th>';
		thtml+='<th>采样点超标率</th>';
		thtml+='<th>未超标点数量</th>';
		thtml+='<th>采样点未超标率</th>';
		thtml+='<th>未超标/超标</th></tr>';
		trthtml+='<tr><th>年份</th>';trthtml+='<th>东丽</th>';
		trthtml+='<th>津南</th>';trthtml+='<th>北辰</th>';
		trthtml+='<th>西青</th>';trthtml+='<th>汉沽</th>';
		trthtml+='<th>塘沽</th>';trthtml+='<th>大港</th>';
		trthtml+='<th>宝坻</th>';trthtml+='<th>宁河</th>';
		trthtml+='<th>蓟州</th>';trthtml+='<th>静海</th>';
		trthtml+='<th>武清</th>';trthtml+='<th>总数</th></tr>';
		$("#htitle").html(html);
		$("#tableHead2").html(thtml);
		$("#trhtitle").html(trhtml);
		$("#trtableHead").html(trthtml);
	}
	
	function initYear(yeararray) {
		var html = '';
		if (yeararray != null) {
			for (i in yeararray) {
				html += '<option value="' + yeararray[i] + '">' + yeararray[i]
						+ '</option>';
			}
			$("#inityear").html(html);
			$("#inityear2").html(html);
		} else {
			$("#inityear").html('');
			$("#inityear2").html(html);
		}
	}

	function initRegion(regionarray) {
		var html = '';
		var html_all = '';
		if (regionarray != null) {
			for (i in regionarray) {
				html += '<option value="' + regionarray[i] + '">' + regionarray[i] + '</option>';
				html_all += '<option value="' + regionarray[i] + '">' + regionarray[i] + '</option>';
			}
			html_all += '<option value="总体">总体</option>';
			$("#initregion").html(html);
			$("#initregionall").html(html_all);
		} else {
			$("#initregion").html('');
			$("#initregionall").html('');
		}
	}

	function initElems(elemarray) {
		var html = '';
		if (elemarray != null) {
			for (i in elemarray) {
				html += '<option value="' + elemarray[i] + '">' + elemarray[i]
						+ '</option>';
			}
			$("#initelem").html(html);
		} else {
			$("#initelem").html('');
		}
	}
})