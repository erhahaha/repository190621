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
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
	var pageName = pathName.substring(pathName.lastIndexOf("/") + 1);

	$('#numOfSamplePoints').submit(function() {
		var year = document.getElementById("inityear").value;
		$.ajax({
			url : projectName + '/sectionelem/analOfSamplePoints',
			type : "POST",
			data : "year=" + year,
			dataType : 'json',
			async : false,
			success : function(data) {
				showpoints(data.object.numsOfpoints);
			}
		})
	});

	function showpoints(array){
		var html = '<tr>';
		var num=0;
		html += '<td>采样点数</td>';
		for (i in array) {
			html += '<td>' + array[i] + '</td>';
			num += array[i];
		}
		html += '<td>' + num + '</td>';
		html += '</tr>';
		$("#tableBody").html(html);
	}
	
	//分析提交
	$('#kindofanal').submit(function() {
		var kind = document.getElementById("detailKind").value;
		var way = document.getElementById("ways").value;
		var year = document.getElementById("inityear2").value;
		var elem = document.getElementById("initelem").value;
		if(kind=="overproof" && way=="op_count"){
			document.getElementById("map_anal").style.display="block";
			document.getElementById("map_anal2").style.display="none";
			document.getElementById("map_anal3").style.display="none";
		}else if(kind=="overproof" && way=="op_mean"){
			document.getElementById("map_anal3").style.display="block";
			document.getElementById("map_anal2").style.display="none";
			document.getElementById("map_anal").style.display="none";
		}else{
			document.getElementById("map_anal2").style.display="block";
			document.getElementById("map_anal").style.display="none";
			document.getElementById("map_anal3").style.display="none";
		}
		$.ajax({
			url : projectName + '/sectionelem/kindofanal',
			type : "POST",
			data : "kind=" + kind+"&way="+ way+"&year="+ year+"&elem="+ elem,
			dataType : 'json',
			async : false,
			success : function(data) {
				if(kind=="overproof" && way=="op_count"){
					overproof_count(data.object.result);
					showbargraph1(data.object.percent);
				}else if(kind=="overproof" && way=="op_pointall"){
					overproof_pointall(data.object.result);
					showpie1(data.object.percent);
				}else if(kind=="overproof" && way=="op_pointregion"){
					overproof_region(data.object.result);
					showpie2(data.object.percent);
				}else if(kind=="overproof" && way=="op_mean"){
					overproof_mean(data.object.result);
					showbargraph2(data.object.result);
				}else if(kind=="securelevel"){
					level(data.object.result,4);
					showpie3(data.object.percent);
				}else if(kind=="pollutionlevel"){
					level(data.object.result,5);
					showpie4(data.object.percent);
				}else if(kind=="accumulatlevel"){
					level(data.object.result,4);
					showpie5(data.object.percent);
				}
			}
		})
	});

	function level(array,num){
		var count=0;
		var html = '';
		html += '<tr><td>点位数量(个)</td>';
		for (i in array) {
			if(count%num==0 && count !=0){	
				html += '</tr><tr><td>点位个数占比(%)</td>';
			}
			html += '<td>'+array[i]+'</td>';
			count++;
		}
		html += '</tr>';
		$("#tableBody2").html(html);
	}
	
	function overproof_mean(array){
		var html = '';
		html += '<tr><td>平均超标倍数</td>';
		for (i in array) {
			html += '<td>'+array[i]+'</td>';
		}
		html += '</tr>';
		$("#tableBody2").html(html);
	}
	
	function overproof_region(array){
		var num=0;
		var html = '';
		html += '<tr><td>超标采样点数量</td>';
		for (i in array) {
			if(num%12==0 && num !=0){
				html += '</tr><tr><td>超标采样点比例(%)</td>';
			}
			html += '<td>'+array[i]+'</td>';
			num++;
		}
		html += '</tr>';
		$("#tableBody2").html(html);
	}
	
	function overproof_count(array){
		var num=0;
		var html = '';
		html += '<tr>';
		for (i in array) {
			if(num%10==0 && num !=0){
				html += '</tr><tr>';
			}
			html += '<td>'+array[i]+'</td>';
			num++;
		}
		html += '</tr>';
		$("#tableBody2").html(html);
	}
	
	function showpie1(value){
		var colorList = ['#C1232B','#008000'];
		var myChart = echarts.init(document.getElementById('map_anal2'));
		myChart.clear();
		var option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    series : [
			        {
			            name: '所占比重',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			                {value:value[0], name:'超标点数量'},
			                {value:value[1], name:'未超标点数量'}
			            ],
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    }
			                }
			            }
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	function showpie2(value){
		var colorList = ['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B', '#FE8463','#9BCA63','#FAD860',
										'#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'];
		var kind = ['东丽','津南','北辰','西青','汉沽','塘沽','大港','宝坻','宁河','蓟州','静海','武清'];
		var myChart = echarts.init(document.getElementById('map_anal2'));
		myChart.clear();
		var option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'horizontal',
			        left: 'left',
			        top:50,
			        data: kind
			    },
			    series : [
			        {
			            name: '所占比重',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			                {value:value[0], name:'东丽'},
			                {value:value[1], name:'津南'},
			                {value:value[2], name:'北辰'},
			                {value:value[3], name:'西青'},
			                {value:value[4], name:'汉沽'},
			                {value:value[5], name:'塘沽'},
			                {value:value[6], name:'大港'},
			                {value:value[7], name:'宝坻'},
			                {value:value[8], name:'宁河'},
			                {value:value[9], name:'蓟州'},
			                {value:value[10], name:'静海'},
			                {value:value[11], name:'武清'}
			            ],
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    }
			                }
			            }
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}

	function showpie3(value){
		//var colorList = ['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B', '#FE8463','#9BCA63','#FAD860',
		//							'#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'];
		var colorList =['#008000','#FFFF00','#FFA500','#FF0000'];
		var kind = ['无风险','低风险','中度风险','高风险'];
		var myChart = echarts.init(document.getElementById('map_anal2'));
		myChart.clear();
		var option = {
			  tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'horizontal',
			        left: 'left',
			        top:70,
			        left:120,
			        data: kind
			    },
			    series : [
			        {
			            name: '所占比重',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			                {value:value[0], name:'无风险'},
			                {value:value[1], name:'低风险'},
			                {value:value[2], name:'中度风险'},
			                {value:value[3], name:'高风险'}
			            ],
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    }
			                }
			            }
			           /* itemStyle: {
			                emphasis: {{b}\n{c}
			                    shadowBlur: 20,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }*/
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}

	function showpie4(value){
		//var colorList = ['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B', '#FE8463','#9BCA63','#FAD860',
		//							'#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'];
		var colorList =['#00FF00','#008000','#FFFF00','#FFA500','#FF0000'];
		var kind = ['无污染','轻微污染','轻度污染','中度污染','重度污染'];
		var myChart = echarts.init(document.getElementById('map_anal2'));
		myChart.clear();
		var option = {
			  tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'horizontal',
			        left: 'left',
			        top:70,
			        left:120,
			        data: kind
			    },
			    series : [
			        {
			            name: '所占比重',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    }
			                }
			            },
			            data:[
			                {value:value[0], name:'无污染'},
			                {value:value[1], name:'轻微污染'},
			                {value:value[2], name:'轻度污染'},
			                {value:value[3], name:'中度污染'},
			                {value:value[4], name:'重度污染'}
			            ]
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	function showpie5(value){
		//var colorList = ['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B', '#FE8463','#9BCA63','#FAD860',
		//							'#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'];
		var colorList =['#008000','#FFFF00','#FFA500','#FF0000'];
		var kind = ['未累计','轻度累计','中度累计','重度累计'];
		var myChart = echarts.init(document.getElementById('map_anal2'));
		myChart.clear();
		var option = {
			  tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'horizontal',
			        left: 'left',
			        top:70,
			        left:120,
			        data: kind
			    },
			    series : [
			        {
			            name: '所占比重',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:[
			                {value:value[0], name:'未累计'},
			                {value:value[1], name:'轻度累计'},
			                {value:value[2], name:'中度累计'},
			                {value:value[3], name:'重度累计'}
			            ],
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    }
			                }
			            }
			           /* itemStyle: {
			                emphasis: {{b}\n{c}
			                    shadowBlur: 20,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }*/
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	function overproof_pointall(array){
		var html = '';
		html += '<tr>';
		for (i in array) {
			html += '<td>'+array[i]+'</td>';
		}
		html += '</tr>';
		$("#tableBody2").html(html);
	}
	
	function showbargraph1(value){
		var myChart = echarts.init(document.getElementById('map_anal'));
		myChart.clear();
		var option = {
			    color: ['#FF0000'],
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        },
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
			            data : ['Cd', 'Hg', 'As', 'Cu', 'Pb', 'Cr', 'Zn', 'Ni'],
			            axisTick: {
			                alignWithLabel: true
			            }
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            name : '百分比',
			            axisLabel: {
			                formatter: '{value} %'
			            }
			        }
			    ],
			    series : [
			        {
			            type:'bar',
			            barWidth: '60%',
			            itemStyle: {
			                normal: {
			                    label: {
			                        show: true,
			                        position: 'top',
			                        formatter: '{b}\n{c}%'
			                    }
			                }
			            },
			            data:value
			          /*  label:{
			            	show:true,
			                position:'inside',
			                formatter: function(param){
			                	return param.value+"%";
			                }
			            }*/
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	function showbargraph2(value){
		var colorList = ['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B', '#FE8463','#9BCA63','#FAD860',
										'#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'];
		var kind = ['东丽','津南','北辰','西青','汉沽','塘沽','大港','宝坻','宁河','蓟州','静海','武清'];
		var myChart = echarts.init(document.getElementById('map_anal3'));
		myChart.clear();
		var option = {
			    //color: ['#3398DB'],
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
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
			            data : kind,
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
			            name:'平均超标倍数',
			            type:'bar',
			            barWidth: '60%',
			            itemStyle: {
			                normal: {
			                    color: function(params) {
			                        return colorList[params.dataIndex]
			                    },
			                    label: {
			                        show: true,
			                        position: 'top',
			                        formatter: '{b}\n{c}'
			                    }
			                }
			            },
			            data:value
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
		                    	
	//界面按钮调试部分
	$(document).ready(function(){
		$('#detailKind').change(function(){ 
			document.getElementById("map_anal").style.display="none";
			document.getElementById("map_anal2").style.display="none";
			document.getElementById("map_anal3").style.display="none";
			//$("#map_anal").empty(); 
			$("#tableBody2").html('');
			var kind = document.getElementById("detailKind").value;
			var html = '';//指各种下拉框
			var thtml = '';//指表格上的文字
			var htmltitle ='';//指副标题
			if(kind=="overproof"){
				document.getElementById("initelem").disabled=false;
				document.getElementById("initregion").disabled=true;
				html+='<option value="op_pointall">点位超标情况分析(总)</option>';
				html+='<option value="op_pointregion">点位超标情况分析(区域)</option>';
				html+='<option value="op_mean">平均超标情况分析</option>';
				html+='<option value="op_count">超标点位数量统计</option>';
				htmltitle='<b>'+document.getElementById("inityear2").value+'年农产品产地采样点'+document.getElementById("initelem").value+'浓度分布情况</b>';
				thtml+='<tr><th>超标点数量</th>';
				thtml+='<th>采样点超标率</th>';
				thtml+='<th>未超标点数量</th>';
				thtml+='<th>采样点未超标率</th>';
				thtml+='<th>未超标/超标</th></tr>';
			}else{
				document.getElementById("initelem").disabled=true;
				document.getElementById("initregion").disabled=true;
				html+='<option value="ot_all">总体</option>';
				html+='<option value="ot_region">普查</option>';
			}
			if(kind=="securelevel"){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位安全评估结果</b>';
				thtml+='<tr><th>各类风险</th>';
				thtml+='<th>无风险</th>';
				thtml+='<th>低风险</th>';
				thtml+='<th>中度风险</th>';
				thtml+='<th>高风险</th></tr>';
			}else if(kind=="pollutionlevel"){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位污染评价结果</b>';
				thtml+='<tr><th>污染程度</th>';
				thtml+='<th>无污染</th>';
				thtml+='<th>轻微污染</th>';
				thtml+='<th>轻度污染</th>';
				thtml+='<th>中度污染</th>';
				thtml+='<th>重度污染</th></tr>';
			}else if(kind=="accumulatlevel"){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位综合累积程度结果</b>';
				thtml+='<tr><th>累积程度</th>';
				thtml+='<th>未累计</th>';
				thtml+='<th>轻度累计</th>';
				thtml+='<th>中度累计</th>';
				thtml+='<th>重度累计</th></tr>';
			}
			$("#htitle").html(htmltitle);
			$("#ways").html(html);
			var ovalue = document.getElementById("ways").value;
			changewidth(ovalue)
			$("#tableHead2").html(thtml);
		});
		
		$('#ways').change(function(){ 
			document.getElementById("map_anal").style.display="none";
			document.getElementById("map_anal2").style.display="none";
			document.getElementById("map_anal3").style.display="none";
			//$("#map_anal").empty(); 
			$("#tableBody2").html('');
			var kind = document.getElementById("detailKind").value;
			var ovalue = document.getElementById("ways").value;
			var thtml = '';//指表格上的文字
			var htmltitle ='';//指副标题
			if(ovalue=="op_pointall" || ovalue=="op_mean" || ovalue=="op_pointregion" ){
				document.getElementById("initelem").disabled=false;
				document.getElementById("initregion").disabled=true;
			}
			else if(ovalue=="ot_all" || ovalue=="op_count"){
				document.getElementById("initelem").disabled=true;
				document.getElementById("initregion").disabled=true;
			}
			else{
				document.getElementById("initelem").disabled=false;
				document.getElementById("initregion").disabled=false;
			}
			if(ovalue=="op_count" ){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县超标点位数量统计</b>';
				thtml+='<tr><th>区县</th>';
				thtml+='<th>镉Cd</th>';thtml+='<th>汞Hg</th>';
				thtml+='<th>砷As</th>';thtml+='<th>铜Cu</th>';
				thtml+='<th>铅Pb</th>';thtml+='<th>铬Cr</th>';
				thtml+='<th>锌Zn</th>';thtml+='<th>镍Ni</th>';
				thtml+='<th>超标量</th></tr>';
			}else if(ovalue=="op_pointall" ){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市农产品产地采样点'+document.getElementById("initelem").value+'浓度分布情况</b>';
				thtml+='<tr><th>超标点数量</th>';
				thtml+='<th>采样点超标率</th>';
				thtml+='<th>未超标点数量</th>';
				thtml+='<th>采样点未超标率</th>';
				thtml+='<th>未超标/超标</th></tr>';
			}else if(ovalue=="op_pointregion" ){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县'+document.getElementById("initelem").value+'浓度超标采样点数量分布情况</b>';
				thtml+='<tr><th>区县</th>';
				thtml+='<th>东丽</th>';thtml+='<th>津南</th>';
				thtml+='<th>北辰</th>';thtml+='<th>西青</th>';
				thtml+='<th>汉沽</th>';thtml+='<th>塘沽</th>';
				thtml+='<th>大港</th>';thtml+='<th>宝坻</th>';
				thtml+='<th>宁河</th>';thtml+='<th>蓟州</th>';
				thtml+='<th>静海</th>';thtml+='<th>武清</th></tr>';
			}else if(ovalue=="op_mean" ){
				htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县采样点'+document.getElementById("initelem").value+'浓度平均超标倍数情况</b>';
				thtml+='<tr><th>区县</th>';
				thtml+='<th>东丽</th>';thtml+='<th>津南</th>';
				thtml+='<th>北辰</th>';thtml+='<th>西青</th>';
				thtml+='<th>汉沽</th>';thtml+='<th>塘沽</th>';
				thtml+='<th>大港</th>';thtml+='<th>宝坻</th>';
				thtml+='<th>宁河</th>';thtml+='<th>蓟州</th>';
				thtml+='<th>静海</th>';thtml+='<th>武清</th></tr>';
			}else{
				if(kind=="securelevel"){
					thtml+='<tr><th>各类风险</th>';
					thtml+='<th>无风险</th>';
					thtml+='<th>低风险</th>';
					thtml+='<th>中度风险</th>';
					thtml+='<th>高风险</th></tr>';
					if(ovalue=="ot_all"){
						htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位安全评估结果</b>';
					}else{
						htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'安全等级风险区域点位情况</b>';
					}
				}else if(kind=="pollutionlevel"){
					thtml+='<tr><th>污染程度</th>';
					thtml+='<th>无污染</th>';
					thtml+='<th>轻微污染</th>';
					thtml+='<th>轻度污染</th>';
					thtml+='<th>中度污染</th>';
					thtml+='<th>重度污染</th></tr>';
					if(ovalue=="ot_all"){
						htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位污染评价结果</b>';
					}else{
						htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'污染点位情况</b>';
					}
				}else if(kind=="accumulatlevel"){
					htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位综合累积程度结果</b>';
					thtml+='<tr><th>累积程度</th>';
					thtml+='<th>未累计</th>';
					thtml+='<th>轻度累计</th>';
					thtml+='<th>中度累计</th>';
					thtml+='<th>重度累计</th></tr>';
					if(ovalue=="ot_all"){
						htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位综合累积程度结果</b>';
					}else{
						htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'累积程度结果</b>';
					}
				}
			}
			changewidth(ovalue);
			$("#htitle").html(htmltitle);
			$("#tableHead2").html(thtml);
		});
		
		$('#inityear2').change(function(){
			changeyear_elem_region();
		});
		
		$('#initelem').change(function(){
			changeyear_elem_region();
		});
	});
	
	function changewidth(ovalue){
		if(ovalue=="op_count"){
			$('#main-left').css({width:'50%'});
		}else{
			$('#main-left').css({width:'100%'});
		}
	}

	function changeyear_elem_region(){
		var htmltitle='';
		var kind = document.getElementById("detailKind").value;
		var ovalue = document.getElementById("ways").value;
		if(ovalue == "op_count"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县超标点位数量统计</b>';
		}else if(ovalue == "op_pointall"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市农产品产地采样点'+document.getElementById("initelem").value+'浓度分布情况</b>';
		}else if(ovalue == "op_pointregion"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县'+document.getElementById("initelem").value+'浓度超标采样点数量分布情况</b>';
		}else if(ovalue=="op_mean" ){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市各区县采样点'+document.getElementById("initelem").value+'浓度平均超标倍数情况</b>';
		}else if(kind=="securelevel" && ovalue=="ot_all"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位安全评估结果</b>';
		}else if(kind=="securelevel" && ovalue=="ot_region"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'安全等级风险区域点位情况</b>';
		}else if(kind=="pollutionlevel" && ovalue=="ot_all"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位污染评价结果</b>';
		}else if(kind=="pollutionlevel" && ovalue=="ot_region"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'污染点位情况</b>';
		}else if(kind=="accumulatlevel" && ovalue=="ot_all"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年天津市土壤重金属点位综合累积程度结果</b>';
		}else if(kind=="accumulatlevel" && ovalue=="ot_region"){
			htmltitle='<b>'+document.getElementById("inityear2").value+'年普查区域土壤重金属'+document.getElementById("initelem").value+'累积程度结果</b>';
		}
		$("#htitle").html(htmltitle);
	}
})