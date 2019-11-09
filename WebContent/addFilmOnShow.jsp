<%@page language="java" pageEncoding="utf-8" 
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/style.css">
<style>
.title{
	font-weight:bold;
	font-size:14px;
}
</style>
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
</head>
<body>
	<div class="main">
		<div class="optitle clearfix">
			<div class="title">添加上映影片&gt;&gt;</div>
		</div>
		<form id="form1" method="post" action="">
			<input type="hidden" value="doAdd">
			<div class="content">
				<table class="box">
					<tr>
						<td class="field">影片名称：</td>
						<td>
						<select name="mid">
						<c:forEach items="${movie }" var="m">
							<option value="${m.id }">${m.name }</option>
						</c:forEach>
						</select>
						<font color="red">*</font>
						</td>
						<td class="field">影片价格/元：</td>
						<td><input name="price" class="text"
							id="textfield2"/><font color="red">*</font></td>

					</tr>
					<tr>
						<td class="field">播放影厅：</td>
						<td>
							<select name="rid" onchange="toQuery(1)">
							<c:forEach items="${room }" var="r">
								<option value="${r.id }"
								<c:if test="${rid == r.id}">selected</c:if>>${r.type }</option>
							</c:forEach>
							</select><font color="red">*</font>
						</td>
						
						<td class="field">放映时间：</td>
						<td><input name="start" type="datetime-local" class="text" /> 
						<font color="red">*</font></td>
					</tr>
					
				</table>
				
				<table class="list">
					<!-- 显示该影厅近期排片场次 -->
					<tr>
						<td>编号</td>
						<td>电影名称</td>
						<td>放映厅</td>
						<td>放映时间</td>
						<td>结束时间</td>
						<td>票价</td>
					</tr>
					<c:forEach items="${pa.items }" var="s" varStatus="i">
					<tr bgcolor="${i.index%2 ==0 ? 'lightblue':'#fff' }">
						<td>${i.index +1 + (pa.currPage-1)*pa.pageSize}</td>
						<td>${s.movie.name }</td>
						<td>${s.room.type }</td>
						<td>
							<fmt:formatDate value="${s.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<fmt:formatDate value="${s.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>${s.price}</td>
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
			<div class="buttons">
				<input type="button" id="button" value="添加排片" class="input-button"
				onclick="toAdd()"/> 
				<input type="button" id="button" 
					onclick="location.href='${pageContext.request.contextPath}/schedule/query'" 
					value="返回" class="input-button"/>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
function toQuery(pageNum){
	
	var rid = $("[name='rid']").val();
	
	location = "${pageContext.request.contextPath}/schedule/queryRoomSchedule?rid=" 
			+ rid +"&currPage=" + pageNum;
}
function toAdd(){
	
	var mid = $("[name='mid']").val();
	var rid = $("[name='rid']").val();
	var price = $("[name='price']").val();
	var start = $("[name='start']").val();
	
	$.post(
		"${pageContext.request.contextPath}/schedule/addSchedule",
		{
			mid:mid,
			rid:rid,
			price:price,
			start:start
		},
		function(data){
			
			if (data == "1") {
				alert("添加成功！");
			}else {
				alert("添加失败！");
			}
			toQuery(1);
		}
	);
}
</script>
</html>













