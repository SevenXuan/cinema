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
		
		影片状态：<select name="condition">
			<option value="">所有排片</option>
			<option value="1"
			<c:if test="${condition == 1 }">selected</c:if>
			>上映影片</option>
			<option value="0"
			<c:if test="${condition == 0 }">selected</c:if>
			>下映影片</option>
		</select>&nbsp;&nbsp;
		<c:remove var="condition" scope="session"/>
		
		<input type="button" name="submit" value="查询" class="button" onclick="toQuery(1)"/>
	</form>
</div>

<div class="main">
	<div class="optitle clearfix">
		<em><input type="button" name="button" value="添加上映影片" class="input-button" 
		onclick="location.href='${pageContext.request.contextPath}/schedule/queryRoomSchedule?rid=1'"/></em>
		<div class="title">上映影片&gt;&gt;</div>
	</div>
	<div class="content">
		<table class="list">
			<tr class="title">
				<td>编号</td>
				<td>电影名称</td>
				<td>放映厅</td>
				<td>放映时间</td>
				<td>结束时间</td>
				<td>票价</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${pa.items }" var="s" varStatus="i">
			<tr bgcolor="${i.index%2 ==0 ? 'lightblue':'#fff' }">
				<td>${i.index +1 + (pa.currPage-1)*pa.pageSize}</td>
				<td><a href="${pageContext.request.contextPath}/schedule/querySeat?id=${s.id}">${s.movie.name }</a></td>
				<td>${s.room.type }</td>
				<td>
					<fmt:formatDate value="${s.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${s.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${s.price}</td>
				<td>${s.condition == 1 ? '正在上映' : '已下映'}</td>
				<td>
				<a href="javascript:cancelMovie('${pageContext.request.contextPath}/schedule/cancelMovie?id=${s.id}')">
							下映</a>
				</td>
			</tr>
			</c:forEach>
			
			<tr>
				<td colspan="8">
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
	
	location = "${pageContext.request.contextPath}/schedule/query?" + $("form").serialize()
			+"&currPage=" + pageNum;
}

function cancelMovie(url){
	
	var pageNum = ${pa.currPage};
	//查询条件，名称
	var name = $("[name='name']").val();
	
	if (confirm("确定要下映该电影吗？")) {
		$.post(
			url,
			function(data){
				
				if (data == "1") {
					alert("下映成功！");
				}else {
					alert("下映失败！");
				}
				location = "${pageContext.request.contextPath}/schedule/query?name="+name
				+ "&currPage=" + pageNum;
			}
		);
	}
}

</script>

</body>
</html>











