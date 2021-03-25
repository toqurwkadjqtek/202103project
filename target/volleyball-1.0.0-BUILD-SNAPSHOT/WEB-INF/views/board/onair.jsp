<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnAir</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
	$('#btnSend').on('click',function(e){
		e.preventDefault();
		sendMessage();
		$('#msg').val('');
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp"%>
	<div class="container">
		<h2>OnAir</h2>
		<div>
			<div id="msgArea" class="col">
			
			</div>
			<div class="col-6">
				<div class="input-group mb-3">
					<input type="text" id="msg" class="form-control">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button" id="btnSend">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6">
		
		</div>
	</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>