<%@page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
</head>
<body>
	<div class="main">
		<div class="optitle clearfix">
			<div class="title">影片信息&gt;&gt;</div>
		</div>
		<div class="content">
			<table class="info" border="1">
				<tr>
					<td>编号</td>
					<td>${movie.id }</td>
					<td rowspan="10" align="center">
					<img alt="${movie.name }" src="${pageContext.request.contextPath}/images/poster/${movie.id }.jpg"></td>
				</tr>
				<tr>
					<td>电影名称</td>
					<td>${movie.name }</td>
				</tr>
				<tr>
					<td>语言</td>
					<td>${language }</td>
				</tr>
				<tr>
					<td>类型</td>
					<td>${movieType }</td>
				</tr>
				<tr>
					<td>主要演员</td>
					<td>${movie.actor }</td>
				</tr>
				<tr>
					<td>导演</td>
					<td>${movie.director }</td>
				</tr>
				<tr>
					<td>上映时间</td>
					<td><fmt:formatDate pattern="yyyy-mm-dd" value="${movie.time }" /></td>
				</tr>
				<tr>
					<td>评分</td>
					<td>${movie.score }</td>
				</tr>
				<tr>
					<td>简介</td>
<%-- 					<td><textarea rows="5" cols="20" readonly>${movie.intro }</textarea></td> --%>
					<td>${movie.intro }</td>
				</tr>
				<tr>
					<td>影片时长</td>
					<td>${movie.duration }分钟</td>
					
				</tr>
				
			</table>
		</div>
	</div>

	<script type="text/javascript">
		
	</script>

</body>
</html>











