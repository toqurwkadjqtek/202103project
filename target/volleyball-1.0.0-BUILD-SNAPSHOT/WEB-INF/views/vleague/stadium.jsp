<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기장</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=qza5cn2rsu"></script>
<script type="text/javascript">
	$(function(){
 		function getMap(){
			const scode=$('#check').val();
			console.log(scode);
			if(scode=='s01'){
				$('#s01').css({background:'#008080',color:'#fff'});
			}
			$.ajax({
				type:'get',
				url:'${path}/vleague/map',
				data:{scode},
				dataType:'json', //돌려받는 데이터 형
				success:function(result){
					console.log(result);
					const x=result.x; //경도
					const y=result.y; //위도
					
					var mapOptions={
						center: new naver.maps.LatLng(y,x),
						zoom: 15
					};
					var map=new naver.maps.Map('map',mapOptions);
					var marker = new naver.maps.Marker({
					    position: new naver.maps.LatLng(y,x),
					    map: map
					});
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		}
		
 		$('.btnStadium').on('click',function(){
 			$(this).css({background:'#008080',color:'#fff'});
 			$('.btnStadium').not(this).css({background:'#fff',color:'#333'});
 			const value=$(this).val();
 			$('#check').val(value);
			getMap();
		});
		
		getMap();
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
	<h2 align="center">경기장 안내</h2>
	<div class="container">
		<div id="stadium">
			<input type="hidden" id="check" value="s01">
			<button class="btnStadium btn-custom" id="s01" value="s01">계양체육관</button>
			<button class="btnStadium btn-custom" id="s02" value="s02">김천실내체육관</button>
			<button class="btnStadium btn-custom" id="s03" value="s03">상록수체육관</button>
			<button class="btnStadium btn-custom" id="s04" value="s04">수원실내체육관</button>
			<button class="btnStadium btn-custom" id="s05" value="s05">유관순체육관</button>
			<button class="btnStadium btn-custom" id="s06" value="s06">의정부실내체육관</button>
			<button class="btnStadium btn-custom" id="s07" value="s07">장충체육관</button>
			<button class="btnStadium btn-custom" id="s08" value="s08">충무체육관</button>
			<button class="btnStadium btn-custom" id="s09" value="s09">화성실내체육관</button>
		</div>
		<div id="divStd">
			<div id="map" style="width:50%;height:400px;"></div>
			<div id="stadiumInfo">
				<table id="tblStd" border="1">
					<tr>
						<td id="contentStd" align="center" vlign="ceneter">데이터 추후 제공 예정</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>