<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Insert title here</title>
		<!-- CSS -->
		        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
		        <link rel="stylesheet" href="${APP_PATH }/assets/bootstrap/css/bootstrap.min.css">
		        <link rel="stylesheet" href="${APP_PATH }/assets/font-awesome/css/font-awesome.min.css">
				<link rel="stylesheet" href="${APP_PATH }/assets/css/form-elements.css">
		        <link rel="stylesheet" href="${APP_PATH }/assets/css/style.css">
		
		  
		
		        <!-- Favicon and touch icons -->
		        <link rel="shortcut icon" href="${APP_PATH }/assets/ico/favicon.png">
		        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${APP_PATH }/assets/ico/apple-touch-icon-144-precomposed.png">
		        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${APP_PATH }/assets/ico/apple-touch-icon-114-precomposed.png">
		        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${APP_PATH }/assets/ico/apple-touch-icon-72-precomposed.png">
		        <link rel="apple-touch-icon-precomposed" href="${APP_PATH }/assets/ico/apple-touch-icon-57-precomposed.png">
				
				  <!-- Javascript -->
		        <script type="text/javascript" src="${APP_PATH }/js/jquery1.9.1.min.js"></script>
		        <script type="text/javascript" src="${APP_PATH }/assets/bootstrap/js/bootstrap.min.js"></script>
		        <script type="text/javascript" src="${APP_PATH }/assets/js/jquery.backstretch.min.js"></script>
		        <script type="text/javascript" src="${APP_PATH }/assets/js/scripts.js"></script>
		        
		        <!--[if lt IE 10]>
		            <script src="${APP_PATH }assets/js/placeholder.js"></script>
		        <![endif]-->
	 </head>
<body>

<!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>天津市农产品产地土壤重金属</h1>
                            <div class="description">
                            	
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<i class="fa fa-user"></i>
                        		</div>
                        		<div class="form-top-right">
                        			<h3>管理员登录</h3>
                        			<div style="height:50px;width:150px;float:left;">
                            			<p id="fail" hidden="true"  style="color:red; font-size:14px;">用户名或密码错误</p> 
                        			</div>
                            	    
                        		</div>
                        		
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="/SoilenvironmentMana/user/checkLogin" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="username">Username</label>
			                        	<input type="text" name="username" placeholder="用户名..." class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="username">Password</label>
			                        	<input type="password" name="password" placeholder="密码..." class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn">登 &nbsp;录</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                   
                </div>
            </div>
            
        </div>


 
	
	
	 <script type="text/javascript">
		$(function(){
			var flag='${loginflag}';
			
			if(flag=='fail'){
				
				$("#fail").attr("hidden",false);
			}else{
				
				$("#fail").attr("hidden",true);
			}
	
			
		
		})
	</script>
	 
	
</body>
</html>