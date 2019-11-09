<%@page language="java" pageEncoding="utf-8" 
	contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>影院管理系统</title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<frameset rows="95,*" cols="*" frameborder="no" border="0" framespacing="0">
	<frame src="admin_top.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" />
	<frameset cols="200,*" frameborder="no" border="0" framespacing="0">
		<frame src="admin_left.jsp" name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame" />
		<frame src="index.jsp" name="mainFrame" id="mainFrame" />
	</frameset>
</frameset>
<noframes><body>
</body></noframes>
</html>
