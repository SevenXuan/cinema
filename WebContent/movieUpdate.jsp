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
	<form action="" method="post">
		<div class="main">
			<div class="optitle clearfix">
				<div class="title">修改影片信息&gt;&gt;</div>
			</div>
			<div class="content">
				<table class="info" border="1">
					<tr >
						<td>编号</td>
						<td>${movie.id }</td>
						<td rowspan="10" align="center">电影海报</td>
					</tr>
					<tr>
						<td>电影名称</td>
						<td><input type="text" name="name" value="${movie.name }" /></td>
					</tr>
					<tr>
						<td>语言</td>
						<td><input type="text" name="lTid" value="${movie.lTid }" /></td>
					</tr>
					<tr>
						<td>类型</td>
						<td><input type="text" name="mTid" value="${movie.mTid }" /></td>
					</tr>
					<tr>
						<td>主要演员</td>
						<td><input type="text" name="actor" value="${movie.actor }" /></td>
					</tr>
					<tr>
						<td>导演</td>
						<td><input type="text" name="director" value="${movie.director }" /></td>
					</tr>
					<tr>
						<td>评分</td>
						<td><input type="text" name="score" value="${movie.score }" /></td>
					</tr>
					<tr>
						<td>简介</td>
						<td><textarea rows="5" name="intro" cols="20">${movie.intro }</textarea></td>
					</tr>
					<tr>
						<td>影片时长</td>
						<td><input type="text" name="duration" value="${movie.duration }" />分钟</td>
					</tr>
				</table>
				<div class="menu" align="center">
					<input type="button"  value="保存" class="button" onclick="toUpdate()" />
					<input type="button" class="button" value="返回" onclick="javaScript:history.back(-1)" />
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		function toQuery(pageNum) {
			location = "${pageContext.request.contextPath}/movie/query?currPage=" + pageNum;
		}

		function toUpdate() {
		
			var pageNum = ${pa.currPage};
			var id = ${movie.id };

			if (confirm("确定要修改以上影片信息吗？")) {
				$.post(
					"${pageContext.request.contextPath }/movie/update", 
					$("form").serialize()+"&id="+id,
					 function(data) {
						if (data == "1") {
							alert("修改成功！");
						} else {
							alert("修改失败！");
						}
						toQuery(pageNum);
					});
			}
		}
	</script>

</body>
</html>











