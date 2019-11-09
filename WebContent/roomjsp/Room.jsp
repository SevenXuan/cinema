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
	min-width: ${leftMargin}px
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
</style>
<script type="text/javascript" src="../js/jquery-1.8.3.js"></script>
<script>
$(document).ready(function(){
	
	var sellSeat = "${schedule.sellSeat}";
	//已售座位字符串分割成一个数组
	var sellSeats = new Array();
	if (sellSeat) {
		sellSeats = sellSeat.split(",");
	}
	
	var damageSeat = "${room.seatId}";
	//损害座位字符串分割成一个数组
	var damageSeats = new Array();
	if (damageSeat) {
		damageSeats = damageSeat.split(",");
	}
	
	//循环遍历所有座位编号，与数组编号对比，相等就改样式
    $('.seat').each(function(){
    	//如果已售座位数组不为空，则遍历数组
    	for (var i = 0; i < sellSeats.length; i++) {
	    	if ($(this).attr('data-seat-id') == sellSeats[i]) {
	    		$(this).toggleClass("selectable");
	    		$(this).toggleClass("sold");
	    		break;
			}
		}
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
<script type="text/javascript" src="../js/seat.js"></script>
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
		<span class="row-id">${n }</span>  
		</c:forEach>         
  </div>

  <div class="seats-container">
    <div class="screen-container" style="left: 25px;">
      <div class="screen">${room.type}银幕中央</div>
      <div class="c-screen-line"></div>
    </div>
	<!-- 二重循环遍历显示座位 -->
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
 
 <!-- 右边显示售票信息 -->
 <div id="info">
 	<table>
 		<tr>
 			<td>影片名称：</td>
 			<td>${schedule.movie.name}</td>
 		</tr>
 		<tr>
 			<td>放映时间：</td>
 			<td><fmt:formatDate value="${schedule.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
 		</tr>
 		<tr>
 			<td>座位编号：</td>
 			<td id="seatId"></td>
 		</tr>
 		<tr>
 			<td>单价（元）：</td>
 			<td>${schedule.price }</td>
 		</tr>
 		<tr>
 			<td>数量：</td>
 			<td id="count"></td>
 		</tr>
 		<tr>
 			<td>总价（元）：</td>
 			<td id="totalPrice"></td>
 		</tr>
 		<tr>
 			<td colspan="2">
 			<input type="button" class="input-button" value="确认选座" onclick="showSeat()">
 			<input type="button" class="input-button" value="返回" onclick="history.back()">
 			</td>
 		</tr>
 	</table>
 </div>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".row span.selectable").click(
		function(){
			$(this).toggleClass("selected");
			$(this).toggleClass("selectable");
			
			var arr = new Array();
			//获取所有被选中的座位编号，添加到数组中
		    $('.selected').each(function(){
		        arr.push($(this).attr('data-seat-id'));
		    });
		    
			//计算总价
			var price = "${schedule.price}";
			var count = arr.length;
		    var totalPrice = count*price;
		    //显示在指定位置
		    $("#totalPrice").html(totalPrice);
		    
		    //将数组转成字符串
		    var seatId = arr.join(',');
		    //显示在指定 位置
		    $("#seatId").html(seatId);
		    
		    //显示数量
		    $("#count").html(count);
		}
	);
});
function showSeat(){
	
    var arr = new Array();
    //获取所有被选中的座位编号
    $('.selected').each(function(){
        arr.push($(this).attr('data-seat-id'));
    })
    if (arr.length == 0) {
		alert("请先选择座位！");
		return;
	}
    
    //数组转为字符串
   // var seatId = arr.join(',');
    
   /*  $.post(
    	"${pageContext.request.contextPath}/ticket/buyTicket",
    	{
    		seatId:seatId
    	},
    	function(data){
    		if (data == 1) {
				alert("选座成功！");
			}else {
				alert("选座失败！");
			}
    		//获取排片的编号
    		var sid = "${schedule.id}";
    		//刷新页面
    		location = "${pageContext.request.contextPath}/ticket/querySeat?sid="+sid;
    	}
    	
    ); */
    
    alert(arr);
    
    $.ajax({
    	  url: "${pageContext.request.contextPath}/ticket/buyTicket",
    	  type: "POST",
    	  data: {
    		  seatId:arr
    	  },
    	  traditional: true,//这里设置为true
    	  success: function(data){
    		if (data == 1) {
				alert("选座成功！");
			}else {
				alert("选座失败！");
			}
    		//获取排片的编号
    		var sid = "${schedule.id}";
    		//刷新页面
    		location = "${pageContext.request.contextPath}/ticket/querySeat?sid="+sid;
    	}
    	});
    
    
}
</script>
</body>
</html>











