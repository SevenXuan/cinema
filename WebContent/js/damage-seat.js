$(document).ready(function(){
	
	$(".row span").click(
			function(){
				$(this).toggleClass("damage");
				$(this).toggleClass("selectable");
	});
});