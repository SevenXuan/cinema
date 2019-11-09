<%@page language="java" pageEncoding="utf-8" 
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<style>
.title{
	font-weight:bold;
	font-size:14px;
}
</style>
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
</head>
<body>
<div class="menu">
</div>
<div class="main">
	<div class="optitle clearfix">
		<div class="title">影厅基本信息&gt;&gt;</div>
	</div>
	<div class="content">
		<table class="list">
			<tr class="title">
				<td>编号</td>
				<td>影厅名称</td>
				<td>座位数量</td>
				<td>损坏座位编号</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${room }" var="r" varStatus="i">
			<tr bgcolor="${i.index%2 ==0 ? 'lightblue':'#fff' }">
				<td>${r.id}</td>
				<td>${r.type }</td>
				<td>${r.seat}</td>
				<td>${r.seatId}</td>
				<td><a href="${pageContext.request.contextPath}/schedule/queryRoomSeat?id=${r.id}">修改</a></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>
</body>
</html>











