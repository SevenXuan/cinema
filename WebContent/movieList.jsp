<%@page language="java" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			电影名称：<input type="text" name="name" value="${keyword }" class="input-text" />
				&nbsp;&nbsp;&nbsp;&nbsp; 
				<input type="button" name="submit" value="查询" class="button" onclick="toQuery(1)" />
		</form>
	</div>
	<div class="main">
		<div class="optitle clearfix">
			<em><input type="button" name="button" value="添加影片" class="input-button" 
			onclick="location.href='${pageContext.request.contextPath}/movieAdd.jsp'"/></em>
			<div class="title">所有影片&gt;&gt;</div>
		</div>
		<div class="content">
			<table class="list">
				<tr class="title">
					<td>编号</td>
					<td>电影名称</td>
					<td>主要演员</td>
					<td>导演</td>
					<td>影片时长</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${pa.items }" var="m" varStatus="i">
					<tr bgcolor="${i.index%2 ==0 ? 'lightblue':'#fff' }">
						<td>${m.id}</td>
						<td><a
							href="javaScript:toUnique(${m.id },0)">${m.name }</a></td>
						<td>${m.actor }</td>
						<td>${m.director }</td>
						<td>${m.duration }</td>
						<td>${m.condition == 1? "正常":"已删除"}</td>
						<td>
							<c:if test="${m.condition == 1}"><a href="JavaScript:toDelete(${m.id})">删除</a></c:if>
							<a href="JavaScript:toUnique(${m.id},1)">修改</a>
						</td>
					</tr>
				</c:forEach>

				<tr>
					<td colspan="7"><c:choose>
							<c:when test="${pa.currPage == 1}">
						首页&nbsp;上一页
					</c:when>
							<c:otherwise>
								<a href="javascript:toQuery(1)">首页</a>
								<a href="javascript:toQuery(${pa.currPage-1})">上一页</a>
							</c:otherwise>
						</c:choose> <c:choose>
							<c:when test="${pa.currPage == pa.totalPage}">
						下一页&nbsp;尾页
					</c:when>
							<c:otherwise>
								<a href="javascript:toQuery(${pa.currPage+1})">下一页</a>
								<a href="javascript:toQuery(${pa.totalPage })">尾页</a>
							</c:otherwise>
						</c:choose> 第&nbsp;${pa.currPage }&nbsp;页&nbsp;/&nbsp;共&nbsp;${pa.totalPage }&nbsp;页（${pa.count}条）
					</td>
				</tr>

			</table>
		</div>
	</div>

	<script type="text/javascript">
	
		function toQuery(pageNum) {

			var name = $("[name='name']").val();
			
			location = "${pageContext.request.contextPath}/movie/query?name="
					+ name + "&currPage=" + pageNum;
		}
		
		function toUnique(id,choose) {
			location = "${pageContext.request.contextPath}/movie/unique?id="+id+"&choose="+choose;
		}
		

		function toDelete(id) {
			
			var url = "${pageContext.request.contextPath }/movie/delete";
			var pageNum = ${pa.currPage };
			
			if (confirm("确定要删除该影片吗？")) {
				$.post(url,
				"id="+id,
				function(data) {

					if (data == "1") {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					toQuery(pageNum);
				});
			}
		}

	</script>
</body>
</html>











