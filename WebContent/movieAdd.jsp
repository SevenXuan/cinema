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
			<div class="title">新增影片&gt;&gt;</div>
		</div>
		<div class="content">
			<form action="">
				<table class="info" border="1">
					<tr>
						<td>电影名称</td>
						<td>
							<input id="check_name" type="text" name="name" />
							<span></span>
						</td>
					</tr>
					<tr>
						<td>语言</td>
						<td>
							<input type="checkbox" name="lTid" value="1">(1中文)
							<input type="checkbox" name="lTid" value="2">(2英文)
							<input type="checkbox" name="lTid" value="3">(3日文)
							<span id="language"></span>
						</td>
					</tr>
					<tr>
						<td>类型</td>
						<td>
							<input type="checkbox" name="mTid" value="1">(1悬疑)
							<input type="checkbox" name="mTid" value="2">(2科幻)
							<input type="checkbox" name="mTid" value="3">(3爱情)
							<input type="checkbox" name="mTid" value="4">(4动作)
							<span id="mtype"></span>
						</td>
					</tr>
					<tr>
						<td>制片方</td>
						<td><input id="check_producer" type="text" name="producer" /><span></span></td>
					</tr>
					<tr>
						<td>发行方</td>
						<td><input id="check_issure" type="text" name="issure" /><span></span></td>
					</tr>
					<tr>
						<td>主要演员</td>
						<td><input id="check_actor" type="text" name="actor" /><span></span></td>
					</tr>
					<tr>
						<td>导演</td>
						<td><input id="check_director" type="text" name="director" /><span></span></td>
					</tr>
					<tr>
						<td>版权到期时间</td>
						<td><input id="check_expiringDate" type="date"
							name="expiringDateStr" /><span class="help-block"></span></td>
					</tr>
					<tr>
						<td>上映时间</td>
						<td><input id="check_timeStr" type="date" name="timeStr" /><span></span></td>
					</tr>
					<tr>
						<td>评分</td>
						<td><input id="check_score" type="text" name="score" /><span></span></td>
					</tr>
					<tr>
						<td>简介</td>
						<td><textarea id="check_intro" rows="5" cols="50"
								name="intro"></textarea><span></span></td>
					</tr>
					<tr>
						<td>影片时长</td>
						<td><input id="check_duration" type="text" name="duration" />分钟<span></span></td>
					</tr>
				</table>
			</form>
			<div class="menu" align="center">
				<input type="button" value="保存" class="button" onclick="toAdd()" />
				<input type="button" class="button" value="返回"
					onclick="javaScript:history.back(-1)" />
			</div>
		</div>
	</div>

	<script type="text/javascript">
	//记录正确填写的数量	
	var count = 0;
	
		//保存信息
		function toAdd() {
			
			//语言类型，至少选择一项
			if ($("[name='lTid']:checked").length==0) {
				$("#language").html("&nbsp;&nbsp;至少选一项!").css("color","red");
				return;
			}else{
				$("#language").html("&nbsp;&nbsp;✔").css("color","green");
			}
			
			//影片类型，至少选择一项
			if ($("[name='mTid']:checked").length==0) {
				$("#mtype").html("&nbsp;&nbsp;至少选一项!").css("color","red");
				return;
			}else{
				$("#mtype").html("&nbsp;&nbsp;✔").css("color","green");
			}
					
			//判断验证结果
			
			if (count != 8) {
				alert("请正确填写所有信息！");
				return;
			}
			
			//ajax
			$.post("${pageContext.request.contextPath }/movie/add", $("form")
					.serialize(), function(data) {
				if (data == "1") {
					alert("添加成功！");
				} else {
					alert("添加失败！");
				}
				location = "${pageContext.request.contextPath }/movie/query";
			});
		}
		
		//表单验证，正则表达式
		
		$(function checkAll() {
			//名称
			$("#check_name").blur(
					function() {
						var name = $(this).val().trim();
						var ret = /[\u4e00-\u9fa5]/;
						if (!ret.test(name)) {
							$(this).next("span").html("请输入中文！").css("color",
									"red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//制片方
			$("#check_producer").blur(
					function() {
						var producer = $(this).val().trim();
						var ret = /[\u4e00-\u9fa5]/;
						if (!ret.test(producer)) {
							$(this).next("span").html("请输入中文！").css("color",
									"red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//发行方
			$("#check_issure").blur(
					function() {
						var issure = $(this).val().trim();
						var ret = /[\u4e00-\u9fa5]/;
						if (!ret.test(issure)) {
							$(this).next("span").html("请输入中文！").css("color",
									"red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//主要演员
			$("#check_actor").blur(
					function() {
						var actor = $(this).val().trim();
						var ret = /^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$/;
						if (!ret.test(actor)) {
							$(this).next("span").html("请输入合法的数据！").css("color",
									"red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//导演
			$("#check_director").blur(
					function() {
						var director = $(this).val().trim();
						var ret = /^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$/;
						if (!ret.test(director)) {
							$(this).next("span").html("请输入合法的数据！").css("color",
									"red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//评分
			$("#check_score").blur(
					function() {
						var score = $(this).val().trim();
						var ret = /^[1-9].\d|10.[0]|0.[1-9]$/;
						if (!ret.test(score)) {
							$(this).next("span").html("请填写1~10的一位小数").css(
									"color", "red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//简介
			$("#check_intro").blur(
					function() {
						var intro = $(this).val().trim();
						var ret = /^.{10,}$/;
						if (!ret.test(intro)) {
							$(this).next("span").html("简介不能为空,至少10个字符!").css(
									"color", "red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});

			//影片时长
			$("#check_duration").blur(
					function() {
						var duration = $(this).val().trim();
						var ret = /^[1-9][0-9][0-9]|[5-9][0-9]$/;
						if (!ret.test(duration)) {
							$(this).next("span")
									.html("&nbsp;&nbsp;请填写2~3位正整数!").css(
											"color", "red");
						} else {
							$(this).next("span").html("&nbsp;&nbsp;✔").css(
									"color", "green");
							count++;
						}
					});
		});
	</script>
</body>
</html>











