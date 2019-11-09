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
	<form method="post" action="">
		电影名称：<input type="text" name="name" value="${keyword }" class="input-text" />&nbsp;&nbsp;
		<c:remove var="keyword" scope="session"/>
		
		放映厅：<select name="rid">
			<option value="">--请选择--</option>
			<c:forEach items="${room}" var="r">
			<option value="${r.id}"
			<c:if test="${r.id == rid }">selected</c:if>>${r.type }</option>
			</c:forEach>
		</select>&nbsp;&nbsp;
		<c:remove var="rid" scope="session"/>
		
		<input type="button" name="submit" value="查询" class="button" onclick="toQuery(1)"/>
	</form>
</div>

<div class="main">
	<div class="optitle clearfix">
		<div class="title">售票记录&gt;&gt;</div>
	</div>
	<div class="content">
		<table class="list">
			<tr class="title">
				<td>编号</td>
				<td>售票时间</td>
				<td>影片名称</td>
				<td>放映时间</td>
				<td>影厅</td>
				<td>座位编号</td>
				<td>数量</td>
				<td>票价</td>
				<td>总价</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${pa.items }" var="si" varStatus="i">
			<tr bgcolor="${i.index%2 ==0 ? 'lightblue':'#fff' }">
				<td>${i.index +1 + (pa.currPage-1)*pa.pageSize}</td>
				<td>
					<fmt:formatDate value="${si.time }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${si.schedule.movie.name }</td>
				<td>
					<fmt:formatDate value="${si.schedule.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${si.schedule.room.type}</td>
				<td>${si.seatId}</td>
				<td>${si.adultNum}</td>
				<td>${si.schedule.price}</td>
				<td>${si.totalPrice}</td>
				<td>
				<a href="javascript:refundTicket('${pageContext.request.contextPath}/ticket/refundTicket?siId=${si.id }')">
							退票</a>
				</td>
			</tr>
			</c:forEach>
			
			<tr>
				<td colspan="10">
				<c:choose>
					<c:when test="${pa.currPage == 1}">
						首页&nbsp;上一页
					</c:when>
					<c:otherwise>
						<a href="javascript:toQuery(1)">首页</a>
						<a href="javascript:toQuery(${pa.currPage-1})">上一页</a>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pa.currPage == pa.totalPage}">
						下一页&nbsp;尾页
					</c:when>
					<c:otherwise>
						<a href="javascript:toQuery(${pa.currPage+1})">下一页</a>
						<a href="javascript:toQuery(${pa.totalPage })">尾页</a>
					</c:otherwise>
				</c:choose>
				第&nbsp;${pa.currPage }&nbsp;页&nbsp;/&nbsp;共&nbsp;${pa.totalPage }&nbsp;页（${pa.count}条）
				</td>
			</tr>
			
		</table>
	</div>
</div>
<script type="text/javascript">
function toQuery(pageNum){
	
	location = "${pageContext.request.contextPath}/ticket/querySellInfo?currPage=" 
		+ pageNum + "&" + $("form").serialize();
}

function refundTicket(url){
	
	var pageNum = ${pa.currPage};
	//查询条件，名称
	var name = $("[name='name']").val();
	
	if (confirm("确定要退票吗？")) {
		$.post(
			url,
			function(data){
				
				if (data == "1") {
					alert("退票成功！");
				}else {
					alert("退票失败！");
				}
				toQuery(pageNum);
			}
		);
	}
}
</script>
</body>
</html>











