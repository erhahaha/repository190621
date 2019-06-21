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
 	<div id="map"></div>
 	<div id="overLay">
        <div id="label">
            <div class="marker"></div>
            <a class="address" target="_blank" id="address"
                href="http://www.openlayers.org/">武汉市
            </a>
        </div>
    </div>
 <script>
 var wuhan = ol.proj.fromLonLat([114.21, 30.37]);
 var map = new ol.Map({
     target: 'map',
     layers: [
         new ol.layer.Tile({
             source: new ol.source.OSM()
         })
     ],
     view: new ol.View({
         center: wuhan,
         zoom: 4
     })
 });
 //实例化overlay标注，添加到地图容器中
 //这样就实现了预先添加标注
 var overlay = new ol.Overlay({
     position: wuhan,                //叠置层的所在位置
     positioning: 'center-center',
     element: document.getElementById('label'),
     // stopEvent: false
 }); 
 overlay.getElement().title = "武汉市";
 map.addOverlay(overlay);
 
 //为地图容器添加单击事件监听
 map.on('click', function(evt){
     var coordinate = evt.coordinate;        //鼠标单击的坐标
     //新增div元素
     var elementDiv = document.createElement('div');
     var markerDiv = document.createElement('div');
     markerDiv.className = 'marker';
     elementDiv.appendChild(markerDiv);
     var addressDiv = document.createElement('a');
     addressDiv.className = 'address';
     addressDiv.innerText = '标注点';
     elementDiv.appendChild(addressDiv);
     var overLayElement = document.getElementById('overLay');
     overLayElement.appendChild(elementDiv);
     //实例化overlay标注，添加到地图容器中
     var newOverlay = new ol.Overlay({
         position: coordinate,
         positioning: 'center-center',
         element: elementDiv,
         // stopEvent: false
     });
     map.addOverlay(newOverlay);
 });

</script>
 </body>
</html>