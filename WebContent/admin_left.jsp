<%@page language="java" pageEncoding="utf-8" 
	contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<style type="text/css">
	li{
		text-align: center;
	}
	img{
		width:100px;
		height:95px;
		vertical-align:middle;
	}
</style>
</head>
<body class="frame-bd">
<ul class="left-menu">
	<li><a href="${pageContext.request.contextPath}/ticket/query" target="mainFrame"><img src="images/gp.png"/>选座购票</a></li>
	<li><a href="${pageContext.request.contextPath}/ticket/querySellInfo" target="mainFrame"><img src="images/sp.png"/>售票记录</a></li>
	<li><a href="${pageContext.request.contextPath}/schedule/query" target="mainFrame"><img src="images/pp.png"/>排片管理</a></li>
	<li><a href="${pageContext.request.contextPath}/movie/query" target="mainFrame"><img src="images/yp.png"/>影片管理</a></li>
	<li><a href="${pageContext.request.contextPath}/schedule/queryRoom" target="mainFrame"><img src="images/yt.png"/>影厅管理</a></li>
</ul>
</body>
</html>
