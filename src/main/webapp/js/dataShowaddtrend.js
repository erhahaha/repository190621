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
		var elem = document.getElementById("initelem").value;
		var region = document.getElementById("initregionall").value;
		document.getElementById("map_anal").style.display="block";
		$.ajax({
			url : projectName + '/sectionelem/trendanal',
			type : "POST",
			data : "way="+ way+"&elem="+ elem+"&region="+ region,
			dataType : 'json',
			async : false,
			success : function(data) {
				if(way=="count_all"){
					showtable(data.object.result,14);
					show(data.object.result,data.object.yearnum)
				}else if(way=="count_overproof"){
					showtable(data.object.result,14);
					show(data.object.result,data.object.yearnum)
				}else if(way=="count_nooverproof"){
					showtable(data.object.result,14);
					show(data.object.result,data.object.yearnum)
				}else if(way=="probabilit_overproof"){
					showtable(data.object.result,6);
					show2(data.object.picture,data.object.yearnum);
				}
			}
		})
	});
	
	function showtable(array,num){
		var count=0;
		var html = '';
		html += '<tr>';
		for (i in array) {
			if(count%num==0 && count !=0){	
				html += '</tr><tr>';
			}
			html += '<td>'+array[i]+'</td>';
			count++;
		}
		html += '</tr>';
		$("#trtableBody").html(html);
	}
	
	function show(array,years){
		var myChart = echarts.init(document.getElementById('map_anal'));
		myChart.clear();
		var kind = ['东丽','津南','北辰','西青','汉沽','塘沽','大港','宝坻','宁河','蓟州','静海','武清','总和'];
		var wq = new Array(); var dl = new Array();
		var jn = new Array(); var bc = new Array();
		var xq = new Array(); var hg = new Array();
		var tg = new Array(); var dg = new Array();
		var bd = new Array(); var nh = new Array();
		var jz = new Array(); var jh = new Array();
		var zh = new Array();
		var num =0;
		for (i in array) {
			 if(num%14==1) dl.push(array[i]);
			 if(num%14==2) jn.push(array[i]);
			 if(num%14==3) bc.push(array[i]);
			 if(num%14==4) xq.push(array[i]);
			 if(num%14==5) hg.push(array[i]);
			 if(num%14==6) tg.push(array[i]);
			 if(num%14==7) dg.push(array[i]);
			 if(num%14==8) bd.push(array[i]);
			 if(num%14==9) nh.push(array[i]);
			 if(num%14==10) jz.push(array[i]);
			 if(num%14==11) jh.push(array[i]);
			 if(num%14==12) wq.push(array[i]);
			 if(num%14==13) zh.push(array[i]);
			 num++;
		}
		 
		// 指定图表的配置项和数据
		var option = {
			    tooltip: { trigger: 'axis'  },
			    legend: {
			    	 orient: 'vertical',
				     left: 'left',
			         data:kind,
			         top:50
			         /*selected: {
			                '东丽': false, '津南': false, '北辰': false,'西青': false, '汉沽': false, '塘沽': false,
			                '大港': false, '宝坻': false, '宁河': false,'蓟州': false, '静海': false, '武清': false
			            }*/
			    },
			    toolbox: {
			        show: true,
			        feature: {
			            dataView: {readOnly: false},
			            magicType: {type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        }
			    },
			    dataZoom: [{
			        type: 'inside',
			        start: 2,
			        end: 96
			    }, {
			        start: 0,
			        end: 10,
			        handleSize: '80%',
			        handleStyle: {
			            color: '#fff',
			            shadowBlur: 3,
			            shadowColor: 'rgba(0, 0, 0, 0.6)',
			            shadowOffsetX: 2,
			            shadowOffsetY: 2
			        }
			    }],
			    xAxis:  {
			        type: 'category',
			        boundaryGap: false,
			    	data: years
			    },
			    yAxis: {
			        type: 'value',
			        axisLabel: {
			            formatter: '{value} '
			        }
			    },
			    series: [
			        {
			            name:'东丽', type:'line',smooth: true,data: dl
			        },
			        {
			            name:'津南', type:'line',smooth: true,data: jn
			        },
			        {
			            name:'北辰', type:'line',smooth: true,data: bc
			        },
			        {
			            name:'西青', type:'line',smooth: true,data: xq
			        },
			        {
			            name:'汉沽', type:'line',smooth: true,data: hg
			        },
			        {
			            name:'塘沽', type:'line',smooth: true,data: tg
			        },
			        {
			            name:'大港', type:'line',smooth: true,data: dg
			        },
			        {
			            name:'宝坻', type:'line',smooth: true,data: bd
			        },
			        {
			            name:'宁河', type:'line',smooth: true,data: nh
			        },
			        {
			            name:'蓟州', type:'line',smooth: true,data: jz
			        },
			        {
			            name:'静海', type:'line',smooth: true,data: jh
			        },
			        {
			            name:'武清', type:'line',smooth: true,data: wq
			        },
			        {
			            name:'总和', type:'line',smooth: true,data: zh
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	function show2(array,years){
		var myChart = echarts.init(document.getElementById('map_anal'));
		myChart.clear();
		
		// 指定图表的配置项和数据
		var option = {
			    tooltip: { trigger: 'axis'  },
			    toolbox: {
			        show: true,
			        feature: {
			            dataView: {readOnly: false},
			            magicType: {type: ['line', 'bar']},
			            restore: {},
			            saveAsImage: {}
			        }
			    },
			    xAxis:  {
			        type: 'category',
			        boundaryGap: false,
			    	data: years
			    },
			    yAxis: {
			        type: 'value',
			        axisLabel: {
			            formatter: '{value} '
			        }
			    },
			    series: [
			        {
			            name:'超标率', type:'line',smooth: true,data: array
			        }]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	$(document).ready(function(){
		$('#ways').change(function(){ 
			$("#trtableBody").html('');
			document.getElementById("map_anal").style.display="none";
			var way = document.getElementById("ways").value;
			var elem = document.getElementById("initelem").value;
			var region = document.getElementById("initregionall").value;
			var thtml = '';//指表格上的文字
			if(way=="count_all"){
				document.getElementById("initelem").disabled=true;
				document.getElementById("initregionall").disabled=true;
			}else if(way=="probabilit_overproof"){
				document.getElementById("initelem").disabled=false;
				document.getElementById("initregionall").disabled=false;
			}else{
				document.getElementById("initelem").disabled=false;
				document.getElementById("initregionall").disabled=true;
			}
			if(way=="probabilit_overproof"){
				thtml+='<tr><th>年份</th>';thtml+='<th>地区</th>';
				thtml+='<th>元素</th>';thtml+='<th>总数</th>';
				thtml+='<th>超标数</th>';thtml+='<th>超标率(%)</th></tr>';
			}else{
				thtml+='<tr><th>年份</th>';thtml+='<th>东丽</th>';
				thtml+='<th>津南</th>';thtml+='<th>北辰</th>';
				thtml+='<th>西青</th>';thtml+='<th>汉沽</th>';
				thtml+='<th>塘沽</th>';thtml+='<th>大港</th>';
				thtml+='<th>宝坻</th>';thtml+='<th>宁河</th>';
				thtml+='<th>蓟州</th>';thtml+='<th>静海</th>';
				thtml+='<th>武清</th>';thtml+='<th>总数</th></tr>';
			}
			changetitle(way);
			$("#trtableHead").html(thtml);
		});
		
		$('#initelem').change(function(){ 
			var way = document.getElementById("ways").value;
			changetitle(way)
		});
		
		$('#initregionall').change(function(){ 
			var way = document.getElementById("ways").value;
			changetitle(way)
		});
	});
	
	function changetitle(way){
		var htmltitle ='';//指副标题
		if(way=="count_all"){
			htmltitle+='<b>天津市农产品产地采样点总量趋势图</b>';
		}else if(way=="count_overproof"){
			htmltitle+='<b>天津市农产品产地采样点'+document.getElementById("initelem").value+'元素超标数趋势图</b>';
		}else if(way=="count_nooverproof"){
			htmltitle+='<b>天津市农产品产地采样点'+document.getElementById("initelem").value+'元素未超标数趋势图</b>';
		}else if(way=="probabilit_overproof"){
			htmltitle+='<b>天津市'+document.getElementById("initregionall").value+'地区采样点'+document.getElementById("initelem").value+'元素超标率数趋势图</b>';
		}
		$("#trhtitle").html(htmltitle);
	}
})