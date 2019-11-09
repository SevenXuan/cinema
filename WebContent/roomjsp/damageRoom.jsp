<%@page language="java" pageEncoding="utf-8" 
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/cinemas-seat.css" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<style>
.seats-block .seats-wrapper {
	display: inline-block;
	min-width: ${leftMargin}px;
}
#info{
	width:280px;
	position:absolute;
	right:60px;
	top:100px;
	font-size:16px;
}
#info td{
	height:30px;
    border: 1px solid #666;
    text-align: center;
    padding: 2px 4px;
}
#button{
	margin-left:275px;
}
input {
    margin: 0 10px;
}
</style>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script>
$(document).ready(function(){
	
	var damageSeat = "${room.seatId}";
	//损坏座位字符串分割成一个数组
	var damageSeats = new Array();
	if (damageSeat) {
		damageSeats = damageSeat.split(",");
	}
	
	//循环遍历所有座位编号，与数组编号对比，相等就改样式
    $('.seat').each(function(){
    	//如果损坏座位数组不为空，则遍历数组
    	for (var i = 0; i < damageSeats.length; i++) {
	    	if ($(this).attr('data-seat-id') == damageSeats[i]) {
	    		$(this).toggleClass("selectable");
	    		$(this).toggleClass("damage");
	    		break;
			}
		}
    })
});
</script>
<script type="text/javascript" src="../js/damage-seat.js"></script>
</head>
<body>
 <div class="main clearfix">
      <div class="hall">
        <div class="seat-example">
          <div class="selectable-example example">
            <span>可选座位</span>
          </div>
          <div class="sold-example example">
            <span>已售座位</span>
          </div>
          <div class="selected-example example">
            <span>已选座位</span>
          </div>
          <div class="damage-example example">
            <span>损坏座位</span>
          </div>
        </div>
	</div>
</div>      
<div class="seats-block" data-cols="15" data-section-id="01" data-section-name="01" data-seq-no="201805040253887">
  <div class="row-id-container">
    <c:forEach begin="1" end="${room.rows }" step="1" var="n">
		<span class="row-id">${n}</span> 
	</c:forEach>         
  </div>

  <div class="seats-container">
    <div class="screen-container" style="left: 25px;">
      <div class="screen">${room.type}银幕中央</div>
      <div class="c-screen-line"></div>
    </div>

    <div class="seats-wrapper">
    <c:forEach begin="1" end="${room.rows }" step="1" var="m">
	  	<div class="row">
	  	<c:forEach begin="1" end="${room.cols }" step="1" var="n">
			<span class="seat selectable"
			 data-seat-id="${m }-${n }"></span>
		</c:forEach>
		</div>
    </c:forEach>
    
    </div>
  </div>
 </div>
 <div id="button">
    <input type="button" class="input-button" value="确认损坏座位" onclick="showSeat()">
 	<input type="button" class="input-button" value="返回" 
 	onclick="location.href='${pageContext.request.contextPath}/schedule/queryRoom'">
 </div>
<script type="text/javascript">
function showSeat(){
	
    var arr = new Array();
    //获取所有被选中的座位编号
    $('.damage').each(function(){
        arr.push($(this).attr('data-seat-id'));
    })
    
    //数组转为字符串
    var seatId = arr.join(',');
    
    $.post(
    	"${pageContext.request.contextPath}/schedule/updateDamageSeat",
    	{
    		seatId:seatId
    	},
    	function(data){
    		if (data == 1) {
				alert("更新成功！");
			}else {
				alert("更新失败！");
			}
    		//获取排片的编号
    		var id = "${room.id}";
    		
    		//刷新页面
    		location = "${pageContext.request.contextPath}/schedule/queryRoomSeat?id="+id;
    	}
    	
    );
}
</script>
</body>
</html>











