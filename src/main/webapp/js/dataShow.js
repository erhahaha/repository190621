$(function() {
	// 获取当前网址，如： http://localhost:80/ybzx/index.jsp  
	var curPath = window.document.location.href;
	// 获取主机地址之后的目录，如： ybzx/index.jsp  
	var pathName = window.document.location.pathname;
	var pos = curPath.indexOf(pathName);
	// 获取主机地址，如： http://localhost:80  
	var localhostPaht = curPath.substring(0, pos);
	// 获取项目名，如：index
	var jspName= pathName.substring(pathName.substr(1).indexOf('/') + 2,pathName.substr(1).indexOf('.') + 1);
	// 获取带"/"的项目名，如：/ybzx
	var projectName = pathName
			.substring(0, pathName.substr(1).indexOf('/') + 1);
	var pageName = pathName.substring(pathName.lastIndexOf("/") + 1);	
	
	$.get(projectName + '/json/TJ.json', function(TJJson) {
		echarts.registerMap('TJ', TJJson);
		var chart = echarts.init(document.getElementById('map'));
		chart.setOption(option = {
			/*
			 * title : { text : '天津市各区县一览图', x : 'center' },
			 */
			tooltip : {
				trigger : 'item',
				backgroundColor : "#808080",// 提示标签背景颜色
				textStyle : {
					color : "#fff"
				}, // 提示标签字体颜色
				formatter : function(params) {
					return params.name;
				}
			},
			toolbox : {
				// 表示是否显示工具箱，更多信息访问：https://blog.csdn.net/xieweikun7/article/details/52766676
				show : false,
				orient : 'vertical',
				left : 'right',
				top : 'center',
				feature : {
					dataView : {
						readOnly : false
					},
					restore : {},
					saveAsImage : {}
				}
			},
			visualMap : {
				min : 100,
				max : 50000,
				realtime : false,
				calculable : true,
				show : false,
				inRange : {
					color : [ 'Pink', 'Violet', 'RoyalBlue', 'Blue',
							'LightSkyBlue', 'Green', 'Yellow', 'Orange',
							'White' ]
				}
			},
			series : [ {
				name : '天津',
				type : 'map',
				mapType : 'TJ',
				zoom : 1.2,
				// true表示地图可以缩放和移动，false表示禁止，scale表示仅缩放，move表示仅移动
				roam : false,
				label : {
					normal : { show : true },
					emphasis : { show : true }
				},

				// layoutCenter : [ '50%', '50%' ],
				// //属性定义地图中心在屏幕中的位置，一般结合layoutSize 定义地图的大小
				itemStyle : {
					normal : {
						label : { show : true }
					},
					emphasis : { 
						label : { show : true }
					}
				},
				data : [ 
					{	name : '蓟州', value : 25000 }, 
					{ name : '武清', value : 25000 }, 
					{ name : '宝坻', value : 25000 }, 
					{ name : '静海', value : 25000 }, 
					{ name : '宁河', value : 25000 },
					{ name : '大港', value : 25000 }, 
					{ name : '塘沽', value : 25000 }, 
					{ name : '西青', value : 25000 }, 
					{ name : '北辰', value : 25000 }, 
					{ name : '东丽', value : 25000 }, 
					{ name : '汉沽', value : 25000 }, 
					{ name : '津南', value : 25000 }, 
					{ name : '天津市区', value : 25000 } 
					],
			} ]
		});
		chart.setOption(option, true);
		chart.on('click', function(params) {
			params.value=1000;
			//alert(pageName);
			// alert(params.name);//此处写点击事件内容
			if(params.name=="天津市区" && pageName !="entertrend"){
				alert("暂无市区数据");
				// alert(jspName);
			}else{
				if(pageName=="enterdata"){
					var kind= document.getElementById("initelem").value;
					var year= document.getElementById("inityear").value;
					$.ajax({
						url : projectName + '/sectionelem/eleConOfsection',
						type : "POST",
						data: "year="+ year +"&kind="+ kind +"&regionName="+params.name,
						dataType : 'json',
						async : false,
						success : function(data) {
							showdata(data.object.resultmap);
						}
					})
					$.ajax({
						url : projectName + '/sectionelem/elemOfSection',
						type : "POST",
						data: "year="+ year +"&kind="+ kind ,
						dataType : 'json',
						async : false,
						success : function(data) {
							show(year,data.object.maxdata,data.object.meandata,data.object.mindata,kind);
						}
					})
				}else if(pageName=="entertrend"){
					var kind= document.getElementById("initelem").value;
					$.ajax({
						url : projectName + '/sectionelem/eleConofregionforyears',
						type : "POST",
						data: "kind="+ kind +"&regionName="+params.name,
						dataType : 'json',
						async : false,
						success : function(data) {
							showtrend(data.object.resultmap);
							show2(params.name,data.object.resultmap);
						}
					})
				}else if(pageName =="enterproduct"){
					var year= document.getElementById("inityear").value;
					var html = '<h3>'+year+'年'+params.name+'地区农产品重金属含量统计</h3>';
					$("#piehead").html(html);
					$.ajax({
						url : projectName + '/productelem/elemOfProduct',
						type : "POST",
						data: "year="+ year +"&regionName="+ params.name,
						dataType : 'json',
						async : false,
						success : function(data) {
							show3(year,params.name,data.object.resultmap);
							show4(data.object.products);
						}
					})
				}
			}
		});
	});
	
	$('#tableshow').submit(function() {
		var detailKind= document.getElementById("detailKind").value;
		var year= document.getElementById("inityear").value;
		var region= document.getElementById("initregion").value;
		if(detailKind=="region"){
			$.ajax({
				url : projectName + '/sectionelem/infoOfRegion',
				type : "POST",
				data: "year="+ year +"&region="+ region ,
				dataType : 'json',
				async : false,
				success : function(data) {
					showregiondata(data.object.allresult);
				}
			})
		}
		else{
			$.ajax({
				url : projectName + '/productelem/infoOfProduct',
				type : "POST",
				data: "year="+ year +"&regionName="+ region ,
				dataType : 'json',
				async : false,
				success : function(data) {
					showproductdata(data.object.result);
				}
			})
		}
	});
	
	$('#formyear').submit(function() {
		var year= document.getElementById("inityear").value;
		var kind= document.getElementById("initelem").value;
		$.ajax({
			url : projectName + '/sectionelem/elemOfSection',
			type : "POST",
			data: "year="+ year +"&kind="+ kind ,
			dataType : 'json',
			async : false,
			success : function(data) {
				show(year,data.object.maxdata,data.object.meandata,data.object.mindata,kind);
			}
		})
	});
	
	$('#formtrend').submit(function() {
		var kind= document.getElementById("initelem").value;
		var region= document.getElementById("initregion").value;
		$.ajax({
			url : projectName + '/sectionelem/eleConofregionforyears',
			type : "POST",
			data: "kind="+ kind +"&regionName="+region,
			dataType : 'json',
			async : false,
			success : function(data) {
				showtrend(data.object.resultmap);
				show2(region,data.object.resultmap);
			}
		})
	});
	
	$('#formproduct').submit(function() {
		var year= document.getElementById("inityear").value;
		var region= document.getElementById("initregion").value;
		var html = '<h3>'+year+'年'+region+'地区农产品重金属含量统计</h3>';
		$("#piehead").html(html);
		$.ajax({
			url : projectName + '/productelem/elemOfProduct',
			type : "POST",
			data: "year="+ year +"&regionName="+ region,
			dataType : 'json',
			async : false,
			success : function(data) {
				show3(year,region,data.object.resultmap);
				show4(data.object.products);
			}
		})
	});
	
	$('#modifyuser').submit(function() {
		var userid= document.getElementById("userid").value;
		var password= document.getElementById("password").value;
		var confirmpassword= document.getElementById("confirmpassword").value;
		var level=document.getElementById("level").value;
		var job= document.getElementById("job").value;
		var jobphone= document.getElementById("jobphone").value;
		var linkphone= document.getElementById("linkphone").value;
		var email= document.getElementById("email").value;
		var address= document.getElementById("address").value;
		if(password==""){
			alert("密码不得为空！");
		}else if(password != confirmpassword){
			alert("两次密码输入不一致！");
		}else{
			$.ajax({
				url : projectName + '/user/modifyuser',
				type : "POST",
				data:"userid="+ userid + "&password="+ password+"&level="+ level+"&job="+ job+"&jobphone="+ jobphone+"&linkphone="+ linkphone+"&email="+ email+"&address="+ address ,
				dataType : 'json',
				async : false,
				success : function(data) {
					if(data.object.result=="success"){
						alert("修改成功");
					}else if(data.object.result=="fail"){
						alert("修改失败");
					}
				}
			})
		}
	});
	
	$('#newuseradd').submit(function() {
		var userid= document.getElementById("userid").value;
		var username= document.getElementById("username").value;
		var password= document.getElementById("password").value;
		var confirmpassword= document.getElementById("confirmpassword").value;
		var level=document.getElementById("level").value;
		var job= document.getElementById("job").value;
		var jobphone= document.getElementById("jobphone").value;
		var linkphone= document.getElementById("linkphone").value;
		var email= document.getElementById("email").value;
		var address= document.getElementById("address").value;
		if(userid==""){
			alert("员工号不得为空！");
		}else if(username==""){
			alert("用户名不得为空！");
		}else if(password==""){
			alert("密码不得为空！");
		}else if(password != confirmpassword){
			alert("两次密码输入不一致！");
		}else{
			$.ajax({
				url : projectName + '/user/addUser',
				type : "POST",
				data: "userid="+ userid +"&username="+ username+"&password="+ password+"&level="+ level+"&job="+ job+"&jobphone="+ jobphone+"&linkphone="+ linkphone+"&email="+ email+"&address="+ address ,
				dataType : 'json',
				async : false,
				success : function(data) {
					if(data.object.result=="success"){
						alert("添加成功");
					}else if(data.object.result=="fail"){
						alert("添加失败");
					}
				}
			})
		}
	});
	
	// 暂时没实现
	$(document).ready(function() {
		//showhome();
		$.ajax({
			url : projectName + '/sectionelem/eleAvgOfAll',
			type : "POST",
			dataType : 'json',
			async : false,
			success : function(data) {
				showhome(data);
			}
		})
	});
	
	// 柱状图
	function show(year,maxarray,meanarray,minarray,elem){
		var myChart = echarts.init(document.getElementById('map2'));

		// 指定图表的配置项和数据
		var option = {
			    title : {
			        text: year+'年重金属'+elem+'含量',
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['最大值', '平均值','最小值']
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    xAxis : [
			        {
			            type : 'value',
			            boundaryGap : [0, 0.01]
			        }
			    ],
			    yAxis : [
			        {
			            type : 'category',
			            data : ['东丽', '津南', '北辰', '西青', '汉沽', '塘沽', '大港', '宝坻', '宁河', '蓟县', '静海', '武清','总体']
			        }
			    ],
			    series : [
			        {
			            name:'最大值',
			            type:'bar',
			            data:maxarray
			        },
			        {
			            name:'平均值',
			            type:'bar',
			            data:meanarray
			        },
			        {
			            name:'最小值',
			            type:'bar',
			            data:minarray
			        }
			    ]
			};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	// 折线图
	function show2(name,array){
		var myChart = echarts.init(document.getElementById('map3'));
		 var years=new Array();
		 var maxs=new Array();
		 var mins=new Array();
		 var means=new Array();
		 for (i in array) {
			 years.push(array[i].year);
			 maxs.push(array[i].maxcontent);
			 mins.push(array[i].mincontent);
			 means.push(array[i].avgcontent);
		 }
		 
		// 指定图表的配置项和数据
		 
		 option = {
					 title: {
					        text: name+'重金属含量走势图',
					    },
				    tooltip: {
				        trigger: 'axis',
				        backgroundColor:'rgba(255,255,255,0.8)',
				        extraCssText: 'box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);',
				        textStyle:{
				            color:'#6a717b',
				        },
				    },
				    toolbox:{
				        right:20,
				        feature:{
				            magicType: {
				                type:['bar']
				            },
				            restore: {},
				            saveAsImage: {},
				            // brush: {},
				        }
				    },
				    grid: {
				        top: '90',
				        left: '3%',
				        right: '8%',
				        bottom: '50',
				        containLabel: true
				    },
				    color: ['#e33331','#129bf8','#4ec67f'],
				    legend: {
				        top: '30',
				        data:['最大值','平均值','最小值']
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
				   xAxis: [
						{
						type: 'category',
						data: years,
						boundaryGap: false,//坐标轴两边留白
				        splitLine: {
				            show: false,
				            lineStyle: {
				                color: ['#D4DFF5']
				            }
				        },
				        axisTick: {
				            show: true
				        },
				        axisLine: {
				            lineStyle: {
				                color: '#666'
				            }
				        },
				    },
					],
				    yAxis: [{
				            name: '零售量（万件）',
							type: 'value',
							axisLabel: {
								textStyle: {
									color: '#666',
								    fontStyle: 'normal',
								}
							}
				    }],
				    series: [{
				        name: '最大值',
				        type: 'line',
				        //stack: '总量',
				        symbolSize: 7,
				        data: maxs,
				    }, {
				        name: '平均值',
				        type: 'line',
				        //stack: '总量',
				        symbolSize: 7,
				        data: means,
				    }, {
				        name: '最小值',
				        type: 'line',
				        //stack: '总量',
				        symbolSize: 7,
				        data: mins,
				    },]
				};

		 
		 
		
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}

	// 饼状图
	function show3(year,regionname,data){
		var myChart = echarts.init(document.getElementById('map4'));
		 var maxs=new Array();
		 var mins=new Array(); 
		 var means=new Array(); 
		 for (i in data) {
			 maxs.push(data[i].maxcontent);
			 mins.push(data[i].mincontent);
			 means.push(data[i].avgcontent);
		 }
		
		// 指定图表的配置项和数据
		var option = {
			title: {
			        "text":year+ "年"+ regionname+"区农作物中重金属含量统计",
			        "textStyle": {
			            "color": "#2F4F4F",
			            "fontWeight": "bold",
			            "fontSize": 19
			        },
			        
			        "left": "3.2%"
			    },
		
		    tooltip: {
		        trigger: 'axis',
		        axisPointer: {type: 'cross'}
		    },
		    toolbox: {
		        feature: {
		            
		        }
		    },
		    legend: {
		        data:['最大值','最小值','平均值'],
		        left:'right'
		    },
		    xAxis: [
		        {
		        	
		            type: 'category',
		            data: ['镉','汞','砷','铜','铅','铬','锌','镍'],
		            axisLabel: {        
                                show: true,
                                textStyle: {
                                    color: '#2F4F4F',
                                    fontSize:'16'
                                }
                            }
                            
                   } 
					            
		    ],
		    yAxis: [
		        {
		            type: 'value',
		            name: '重金属含量(mg/kg)',
		           
		            axisLabel: {
		            	show: true,
                                textStyle: {
                                    color: '#2F4F4F',
                                    fontSize:'16'
                                },
		                formatter: '{value}'
		            }
		        }
		    ],
		    series: [
		        {
		            name:'最大值',
		            type:'bar',
		            itemStyle:{normal:{color: 'red'}},
		            data:maxs,
		        },
		        {
		            name:'最小值',
		            type:'bar',
		            itemStyle:{normal:{color:'#99cccc'}},
		            data:mins
		        },
		        {
		            name:'平均值',
		            type:'line',
		            yAxisIndex: 0,
		            itemStyle:{normal:{color:'#ff9933'}},
		            data:means,
		             markPoint : {
		                color:'blue',
		                data : [
		                    {type : 'max', name : '最大值'},
		                     {type : 'min', name : '最小值'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name : '平均值'}
		                ]
		            }
		        }
		    ]
		};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	}
	
	// 显示农作物种类
	function show4(productslist){
		var html = '';
		if (productslist != null) {
			for (i in productslist) {
				html +="<div style='float:left;padding-top:5px; margin-left: 2px;margin-top: 2px;width: 90px; height:32px;text-align:center;background-color:#B0E2FF; font-size:18px'>";
				html +=productslist[i].product.name;
				html +="</div>";
			}
			$("#producelist").html(html);
		} else {
			$("#producelist").html('');
		}
	}

	//动态显示地区元素值
	function showhome(array){
		var dataMap = {};
		function dataFormatter(obj) {
			var pList = ['东丽', '津南', '北辰', '西青', '汉沽', '塘沽', '大港', '宝坻', '宁河', '蓟州', '静海', '武清'];
			var temp;
			for (var year = array.object.years[0]; year <=array.object.years[array.object.years.length-1]; year++) {
				var max = 0;
				var sum = 0;
				temp = obj['y'+year.toString()];
				for (var i = 0, l = temp.length; i < l; i++) {
					max = Math.max(max, temp[i]);
					sum += temp[i];
					obj['y'+year.toString()][i] = {
						name : pList[i],
						value : temp[i]
					}
				}
				obj[year + 'max'] = Math.floor(max / 100) * 100;
				obj[year + 'sum'] = sum;
			}
			return obj;
		}

		dataMap.dataCd = dataFormatter(array.object.CdList);
		dataMap.dataHg = dataFormatter(array.object.HgList);
		dataMap.dataAs = dataFormatter(array.object.AsList);
		dataMap.dataCu = dataFormatter(array.object.CuList);
		dataMap.dataPb = dataFormatter(array.object.PbList);
		dataMap.dataCr = dataFormatter(array.object.CrList);
		dataMap.dataZn = dataFormatter(array.object.ZnList);
		dataMap.dataNi = dataFormatter(array.object.NiList);
		
		var optionsdata=[];
		for(var i = 0;i<array.object.years.length;i++){
			  optionsdata.push({
				      title: {text : array.object.years[i].toString()+'年天津市土壤金属含量平均值'},
				      series:  [ {data : dataMap.dataCd['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataHg['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataAs['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataCu['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataPb['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataCr['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataZn['y'+array.object.years[i].toString()]}, 
									  {data : dataMap.dataNi['y'+array.object.years[i].toString()]} ]    
			});
		}						
							
		var myChart = echarts.init(document.getElementById('mainmap'));
		var option = {
			baseOption : {
				timeline : {
					axisType : 'category',
					autoPlay : true,
					playInterval : 1000,
					data : array.object.years,
					label : {
						formatter : function(s) {
							return (new Date(s)).getFullYear();
						}
					}
				},
				tooltip : {},
				legend : {
					x : 'right',
					data : ['镉Cd', '汞Hg', '砷As', '铜Cu', '铅Pb', '铬Cr' , '锌Zn', '镍Ni' ],
					selected : {
						/*'铬Cr' : false,
						'锌Zn' : false,
						'镍Ni' : false*/
					}
				},
				calculable : true,
				grid : {
					top : 80,
					bottom : 100,
					tooltip : {
						trigger : 'axis',
						axisPointer : {
							type : 'shadow',
							label : {
								show : true,
								formatter : function(params) {
									return params.value.replace('\n', '');
								}
							}
						}
					}
				},
				xAxis : [ {
					'type' : 'category',
					'axisLabel' : {
						'interval' : 0
					},
					'data' : [  '武清', '汉沽', '静海', '蓟州', '大港', '宝坻', '北辰', '东丽',
						'宁河', '西青', '津南' ,'塘沽' ],
					splitLine : {
						show : false
					}
				} ],
				yAxis : [ {
					type : 'value',
					name : '金属含量（mg/kg）'
				} ],
				series : [
					{ name : '镉Cd', type : 'bar' }, 
					{ name : '汞Hg', type : 'bar' }, 
					{ name : '砷As', type : 'bar' }, 
					{ name : '铜Cu', type : 'bar' }, 
					{ name : '铅Pb', type : 'bar' }, 
					{ name : '铬Cr', type : 'bar'} , 
					{ name : '锌Zn', type : 'bar' }, 
					{ name : '镍Ni', type : 'bar'}]
			},
			
				options :optionsdata
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
	}
	
	
	// 显示某一地区的某一元素所有数据
	function showdata(array){
		var html = '';
		if (array != null) {
			for (i in array) {
				html += '<tr>';
				html += '<td>' + array[i].regionName + '</td>';
				html += '<td>' + array[i].sectionNumber + '</td>';
				html += '<td>' + array[i].year + '</td>';
				html += '<td>' + array[i].latitude + '</td>';
				html += '<td>' + array[i].longitude + '</td>';
				html += '<td>' + array[i].eleName + '</td>';
				html += '<td>' + array[i].elecontent + '</td>';
				html += '</tr>';
			}
			$("#tableBody").html(html);
		} else {
			$("#tableBody").html('');
		}
	}
	
	function showregiondata(array){
		var html = '';
		if (array != null) {
			for (i in array) {
				html += '<tr>';
				html += '<td>' +array[i].name+ '</td>';
				html += '<td>' +array[i].year + '</td>';
				html += '<td>' +array[i].sectionNumber + '</td>';
				html += '<td>' +array[i].elemCd + '</td>';
				html += '<td>' +array[i].elemHg + '</td>';
				html += '<td>' +array[i].elemAs + '</td>';
				html += '<td>' +array[i].elemCu + '</td>';
				html += '<td>' +array[i].elemPb + '</td>';
				html += '<td>' +array[i].elemCr + '</td>';
				html += '<td>' +array[i].elemZn + '</td>';
				html += '<td>' +array[i].elemNi + '</td>';
				html += '<td>' +array[i].elemPH + '</td>';
				html += '</tr>';
				
			}
			$("#tableBody").html(html);
		} else {
			$("#tableBody").html('');
		}
	}
	
	function showproductdata(array){
		var html = '';
		if (array != null) {
			for (i in array) {
				html += '<tr>';
				html += '<td>' + array[i].name + '</td>';
				html += '<td>' + array[i].year + '</td>';
				html += '<td>' + array[i].sectionNumber + '</td>';
				html += '<td>' + array[i].cproduct + '</td>';
				html += '<td>' +array[i].elemCd + '</td>';
				html += '<td>' +array[i].elemHg + '</td>';
				html += '<td>' +array[i].elemAs + '</td>';
				html += '<td>' +array[i].elemCu + '</td>';
				html += '<td>' +array[i].elemPb + '</td>';
				html += '<td>' +array[i].elemCr + '</td>';
				html += '<td>' +array[i].elemZn + '</td>';
				html += '<td>' +array[i].elemNi + '</td>';
				html += '</tr>';
			}
			$("#tableBody").html(html);
		} else {
			$("#tableBody").html('');
		}
	}
	
	// 显示某一地区的某一元素最大，最小，平均值
	function showtrend(array){
		var html = '';
		if (array != null) {
			for (i in array) {
				html += '<tr>';
				html += '<td>' + array[i].year + '</td>';
				html += '<td>' + array[i].regionName + '</td>';
				html += '<td>' + array[i].eleName + '</td>';
				html += '<td>' + array[i].avgcontent + '</td>';
				html += '<td>' + array[i].maxcontent + '</td>';
				html += '<td>' + array[i].mincontent + '</td>';
				html += '</tr>';
			}
			$("#tableBody").html(html);
		} else {
			$("#tableBody").html('');
		}
	}
	
	//注释
	function zhushi(){
	/*function showhome(array){
	 function showhome(){
		var dataMap = {};
		function dataFormatter(obj) {
			var pList = ['东丽', '津南', '北辰', '西青', '汉沽', '塘沽', '大港', '宝坻', '宁河', '蓟州', '静海', '武清'];
			var temp;
			for (var year = 2014; year <=2017; year++) {
				var max = 0;
				var sum = 0;
				temp = obj['y'+year.toString()];
				for (var i = 0, l = temp.length; i < l; i++) {
					max = Math.max(max, temp[i]);
					sum += temp[i];
					obj['y'+year.toString()][i] = {
						name : pList[i],
						value : temp[i]
					}
				}
				obj[year + 'max'] = Math.floor(max / 100) * 100;
				obj[year + 'sum'] = sum;
			}
			return obj;
		}

		dataMap.dataA = dataFormatter({
			y2017 : [ 16251.93, 11307.28, 24515.76, 11237.55, 14359.88, 22226.7, 10568.83, 12582, 19195.69, 49110.27, 32318.85, 15300.65],
			y2016 : [ 14113.58, 9224.46, 20394.26, 9200.86, 11672, 18457.27, 8667.58, 10368.6, 17165.98, 41425.48, 27722.31, 12359.33 ],
			y2015 : [ 12153.03, 7521.85, 17235.48, 7358.31, 9740.25, 15212.49, 7278.75, 8587, 15046.45, 34457.3, 22990.35, 10062.82 ],
			y2014 : [ 11115, 6719.01, 16011.97, 7315.4, 8496.2, 13668.58, 6426.1, 8314.37, 14069.87, 30981.98, 21462.69, 8851.66 ]
		});

		dataMap.dataB= dataFormatter({
			// max : 4000,
			y2017 : [ 136.27, 159.72, 2905.73, 641.42, 1306.3, 1915.57, 1277.44, 1701.5, 124.94, 3064.78, 1583.04, 2015.31],
			y2016 : [ 124.36, 145.58, 2562.81, 554.48, 1095.28, 1631.08, 1050.15, 1302.9, 114.15, 2540.1, 1360.56, 1729.02],
			y2015 : [ 118.29, 128.85, 2207.34, 477.59, 929.6, 1414.9, 980.57, 1154.33, 113.82, 2261.86, 1163.08, 1495.45 ],
			y2014 : [ 112.83, 122.58, 2034.59, 313.58, 907.95, 1302.02, 916.72, 1088.94, 111.8, 2100.11, 1095.96, 1418.09 ]
		});

		dataMap.dataC = dataFormatter({
			// max : 26600,
			y2017 : [ 3752.48, 5928.32, 13126.86, 6635.26, 8037.69, 12152.15, 5611.48, 5962.41, 7927.89, 25203.28, 16555.58, 8309.38 ],
			y2016 : [ 3388.38, 4840.23, 10707.68, 5234, 6367.69, 9976.82, 4506.31, 5025.15, 7218.32, 21753.93, 14297.93, 6436.62 ],
			y2015 : [ 2855.55, 3987.84, 8959.83, 3993.8, 5114, 7906.34, 3541.92, 4060.72, 6001.78, 18566.37, 11908.49, 4905.22 ],
			y2014 : [ 2626.41, 3709.78, 8701.34, 4242.36, 4376.19, 7158.84, 3097.12, 4319.75, 6085.84, 16993.34, 11567.42, 4198.93 ]
		});

		dataMap.dataD = dataFormatter({
			// max : 25000,
			y2017 : [ 12363.18, 5219.24, 8483.17, 3960.87, 5015.89, 8158.98, 3679.91, 4918.09, 11142.86, 20842.21, 14180.23, 4975.96 ],
			y2016 : [ 10600.84, 4238.65, 7123.77, 3412.38, 4209.03, 6849.37, 3111.12, 4040.55, 9833.51, 17131.45, 12063.82, 4193.69 ],
			y2015 : [ 9179.19, 3405.16, 6068.31, 2886.92, 3696.65, 5891.25, 2756.26, 3371.95, 8930.85, 13629.07, 9918.78, 3662.15 ],
			y2014 : [ 8375.76, 2886.65, 5276.04, 2759.46, 3212.06, 5207.72, 2412.26, 2905.68, 7872.23, 11888.53, 8799.31, 3234.64 ]
		});

		dataMap.dataE = dataFormatter({
			// max : 3600,
			y2017 : [ 1074.93, 411.46, 918.02, 224.91, 384.76, 876.12, 238.61, 492.1, 1019.68, 2747.89, 1677.13, 634.92 ],
			y2016 : [ 1006.52, 377.59, 697.79, 192, 309.25, 733.37, 212.32, 391.89, 1002.5, 2600.95, 1618.17, 532.17 ],
			y2015 : [ 1062.47, 308.73, 612.4, 173.31, 286.65, 605.27, 200.14, 301.18, 1237.56, 2025.39, 1316.84, 497.94 ],
			y2014 : [ 844.59, 227.88, 513.81, 166.04, 273.3, 500.81, 182.7, 244.47, 939.34, 1626.13, 1052.03, 431.27 ]
		});

		dataMap.dataF = dataFormatter({
			// max : 3200,
			y2017 : [ 2215.41, 756.5, 746.01, 519.32, 447.46, 755.57, 207.65, 370.78, 2277.4, 2600.11, 2730.29, 503.85 ],
			y2016 : [ 1863.61, 572.99, 615.42, 448.3, 346.44, 639.27, 190.12, 304.59, 1950.96, 2105.92, 2326.58, 396.17 ],
			y2015 : [ 1603.63, 461.2, 525.67, 361.64, 291.1, 560.2, 180.83, 227.54, 1804.28, 1596.98, 1899.33, 359.6 ],
			y2014 : [ 1519.19, 368.1, 420.74, 290.91, 219.09, 455.07, 147.24, 177.43, 1414.21, 1298.48, 1653.45, 313.81 ]
		});
		dataMap.dataG = dataFormatter({
			// max : 3200,
			y2017 : [ 2215.41, 756.5, 746.01, 519.32, 447.46, 755.57, 207.65, 370.78, 2277.4, 2600.11, 2730.29, 503.85 ],
			y2016 : [ 1863.61, 572.99, 615.42, 448.3, 346.44, 639.27, 190.12, 304.59, 1950.96, 2105.92, 2326.58, 396.17 ],
			y2015 : [ 1603.63, 461.2, 525.67, 361.64, 291.1, 560.2, 180.83, 227.54, 1804.28, 1596.98, 1899.33, 359.6 ],
			y2014 : [ 1519.19, 368.1, 420.74, 290.91, 219.09, 455.07, 147.24, 177.43, 1414.21, 1298.48, 1653.45, 313.81 ]
		});
		dataMap.dataH = dataFormatter({
			// max : 3200,
			y2017 : [ 2215.41, 756.5, 746.01, 519.32, 447.46, 755.57, 207.65, 370.78, 2277.4, 2600.11, 2730.29, 503.85 ],
			y2016 : [ 1863.61, 572.99, 615.42, 448.3, 346.44, 639.27, 190.12, 304.59, 1950.96, 2105.92, 2326.58, 396.17 ],
		    y2015 : [ 1603.63, 461.2, 525.67, 361.64, 291.1, 560.2, 180.83, 227.54, 1804.28, 1596.98, 1899.33, 359.6 ],
			y2014 : [ 1519.19, 368.1, 420.74, 290.91, 219.09, 455.07, 147.24, 177.43, 1414.21, 1298.48, 1653.45, 313.81 ]
		});
		
		var myChart = echarts.init(document.getElementById('mainmap'));
		var option = {
			baseOption : {
				timeline : {
					axisType : 'category',
					autoPlay : true,
					playInterval : 1000,
					data : [ '2014', '2015', '2016','2017'],
					label : {
						formatter : function(s) {
							return (new Date(s)).getFullYear();
						}
					}
				},
				title : {
					subtext : '数据来自国家统计局'
				},
				tooltip : {},
				legend : {
					x : 'right',
					data : ['氢', '氦', '锂', '铍', '硼', '碳' ],
					selected : {
						'铍' : false,
						'硼' : false,
						'碳' : false
					}
				},
				calculable : true,
				grid : {
					top : 80,
					bottom : 100,
					tooltip : {
						trigger : 'axis',
						axisPointer : {
							type : 'shadow',
							label : {
								show : true,
								formatter : function(params) {
									return params.value.replace('\n', '');
								}
							}
						}
					}
				},
				xAxis : [ {
					'type' : 'category',
					'axisLabel' : {
						'interval' : 0
					},
					'data' : [  '武清', '汉沽', '静海', '蓟州', '大港', '宝坻', '北辰', '东丽',
						'宁河', '西青', '津南' ,'塘沽' ],
					splitLine : {
						show : false
					}
				} ],
				yAxis : [ {
					type : 'value',
					name : 'GDP（亿元）'
				} ],
				series : [
					{ name : '氢', type : 'bar' }, 
					{ name : '氦', type : 'bar' }, 
					{ name : '锂', type : 'bar' }, 
					{ name : '铍', type : 'bar' }, 
					{ name : '硼', type : 'bar' }, 
					{ name : '碳', type : 'bar'} ]
			},
			
			options : [ {
								title : {
									text : '2014全国宏观经济指标'
								},
								series : [ {data : dataMap.dataA['y2014']}, 
												{data : dataMap.dataF['y2014']}, 
												{data : dataMap.dataE['y2014']}, 
												{data : dataMap.dataB['y2014']}, 
												{data : dataMap.dataC['y2014']}, 
												{data : dataMap.dataD['y2014']} ]}, 
								{
								title : {
									text : '2015全国宏观经济指标'
								},
								series : [ {data : dataMap.dataA['y2015']}, 
												{data : dataMap.dataF['y2015']}, 
												{data : dataMap.dataE['y2015']}, 
												{data : dataMap.dataB['y2015']}, 
												{data : dataMap.dataC['y2015']}, 
												{data : dataMap.dataD['y2015']} ]}, 
								{
								title : {
									text : '2016全国宏观经济指标'
								},
								series : [ {data : dataMap.dataA['y2016']}, 
												{data : dataMap.dataF['y2016']}, 
												{data : dataMap.dataE['y2016']}, 
												{data : dataMap.dataB['y2016']}, 
												{data : dataMap.dataC['y2016']}, 
												{data : dataMap.dataD['y2016']} ]}, 
								{
								title : {
									text : '2017全国宏观经济指标'
								},
								series : [ {data : dataMap.dataA['y2017']}, 
									{data : dataMap.dataF['y2017']}, 
									{data : dataMap.dataE['y2017']}, 
									{data : dataMap.dataB['y2017']}, 
									{data : dataMap.dataC['y2017']}, 
									{data : dataMap.dataD['y2017']} ]}
			]};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
	}
	 }*/
	}
	
})