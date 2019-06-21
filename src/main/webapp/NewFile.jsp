<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <% 	pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
   <title>OpenLayers 3地图示例</title>        
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">    
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <link href="${APP_PATH}/css/ol.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="${APP_PATH}/js/ol.js" charset="utf-8"></script>
  <!-- <link rel="stylesheet" type="text/css" href="my.css"> -->
 </head>
 <body>
 	<div id="map" style="width:450px;height: 600px"></div>
    <!-- <script>
      // 创建地图
      new ol.Map({
            // 设置地图图层
            layers: [
              // 创建一个使用Open Street Map地图源的瓦片图层
              new ol.layer.Tile({source: new ol.source.OSM()})
            ],
            // 设置显示地图的视图
            view: new ol.View({
              //center: ol.proj.transform([117.2, 39.12], 'EPSG:4326', 'EPSG:3857'),    // 定义地图显示中心于经度0度，纬度0度处
              center: [117.2, 39.12],
              projection: 'EPSG:4326',
              zoom: 10            // 并且定义地图显示层级为2(设置放大多少)
            }),
            // 让id为map的div作为地图的容器
            target: 'map'    
        });
    </script> -->
    
    <script type="text/javascript">
    var pathName = window.document.location.pathname;
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    var layer =new ol.layer.Vector({
        source: new ol.source.Vector({
          	url: projectName + '/json/TJ.json',     // 地图来源
            format: new ol.format.GeoJSON()   // 解析矢量地图的格式化类
            //features: (new ol.format.GeoJSON()).readFeatures(projectName + '/json/TJ.json')
        })
    })
    
    //创建地图
    var map = new ol.Map({
        layers: [
            // 底图用Open Street Map 地图
            /* new ol.layer.Tile({
                source: new ol.source.OSM()
            }), */
            // 再加载一个geojson的矢量地图
        	layer
        ],
        view: new ol.View({ 
        	//extent: [117, 38.7, 118.5, 39.2],
            center: [117.4, 39.45],
            zoom: 8.8,
            minZoom: 8,
            maxZoom: 14,
            projection: 'EPSG:4326'
        }),
        target: 'map'
    });
    
  /*   var coordinate1 = new Array(116.55,117.22,117.04,117.11,117.21,117.40,117.23,117.09,116.57,117.20,117.34,117.47,117.21);
    var coordinate2 = new Array(38.54,38.43,39.03,39.07,38.57,38.59,39.09,39.15,39.30,39.39,39.22,39.12,39.59);
    var name = new Array("静海","大港","西青","天津市区","津南","塘沽","东丽","北辰","武清","宝坻","宁河","汉沽","蓟州");
    for(var i=0;i<coordinate1.length;i++){
    	var anchor = new ol.Feature({ geometry: new ol.geom.Point(coordinate1[i],coordinate2[i]) });
    	anchor.setStyle(new ol.style.Style({
            text: new ol.style.Text({
              text: name[i],
              fill: new ol.style.Fill({
                  color: 'red'
              })
            })
          }));
    	layer.getSource().addFeature(anchor);
    } */
    var anchor = new ol.Feature({ geometry: new ol.geom.Point([116.55, 38.54]) });
    var anchor2 = new ol.Feature({ geometry: new ol.geom.Point([117.22, 38.43]) });
    var anchor3 = new ol.Feature({ geometry: new ol.geom.Point([117.04, 39.03]) });
    var anchor4 = new ol.Feature({ geometry: new ol.geom.Point([117.11, 39.07]) });
    var anchor5 = new ol.Feature({ geometry: new ol.geom.Point([117.21, 38.57]) });
    var anchor6 = new ol.Feature({ geometry: new ol.geom.Point([117.40, 38.59]) });
    var anchor7 = new ol.Feature({ geometry: new ol.geom.Point([117.23, 39.09]) });
    var anchor8 = new ol.Feature({ geometry: new ol.geom.Point([117.09, 39.15]) });
    var anchor9 = new ol.Feature({ geometry: new ol.geom.Point([116.57, 39.30]) });
    var anchor10 = new ol.Feature({ geometry: new ol.geom.Point([117.20, 39.39]) });
    var anchor11 = new ol.Feature({ geometry: new ol.geom.Point([117.34, 39.22]) });
    var anchor12 = new ol.Feature({ geometry: new ol.geom.Point([117.47, 39.12]) });
    var anchor13 = new ol.Feature({ geometry: new ol.geom.Point([117.21, 39.59]) });
      // 设置文字style
      anchor.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '静海', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor2.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '大港', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor3.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '西青', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor4.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '天津市区', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor5.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '津南', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor6.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '塘沽', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor7.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '东丽', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor8.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '北辰', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor9.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '武清', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor10.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '宝坻', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor11.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '宁河', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor12.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '汉沽', fill: new ol.style.Fill({ color: 'red'})  })  }));
      anchor13.setStyle(new ol.style.Style({ text: new ol.style.Text({text: '蓟州', fill: new ol.style.Fill({ color: 'red'})  })  }));
      layer.getSource().addFeature(anchor); layer.getSource().addFeature(anchor2);  layer.getSource().addFeature(anchor3); 
      layer.getSource().addFeature(anchor4); layer.getSource().addFeature(anchor5);  layer.getSource().addFeature(anchor6); 
      layer.getSource().addFeature(anchor7); layer.getSource().addFeature(anchor8);  layer.getSource().addFeature(anchor9); 
      layer.getSource().addFeature(anchor10); layer.getSource().addFeature(anchor11);  layer.getSource().addFeature(anchor12); 
      layer.getSource().addFeature(anchor13); 
</script>
 </body>
</html>