<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기일정 및 결과</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="template_source" type="text/x-handlebars-template">
	<select id="vdate" name="vdate">
		<option value="10">2020년 10월</option>
		<option value="11">2020년 11월</option>
		<option value="12">2020년 12월</option>
		<option value="01">2021년 1월</option>
		<option value="02">2021년 2월</option>
		<option value="03">2021년 3월</option>
		<option value="04">2021년 4월</option>
	</select>
</script>
<script id="template_source2" type="text/x-handlebars-template">
	<select id="round" name="round">
		<option value="1">1라운드</option>
		<option value="2">2라운드</option>
		<option value="3">3라운드</option>
		<option value="4">4라운드</option>
		<option value="5">5라운드</option>
		<option value="6">6라운드</option>
		<option value="7">포스트시즌</option>
	</select>
</script>
<script id="template_source3" type="text/x-handlebars-template">
<table border="1">
	<tr>
		<th class="text-center">날짜</th>
		<th class="text-center">시간</th>
		<th class="text-center">순번</th>
		<th class="text-center">구분</th>
		<th class="text-center">경기</th>
		<th class="text-center">경기장</th>
		<th class="text-center">생중계</th>
		<th class="text-center">라운드</th>
	</tr>
	{{#each.}}
		{{#todayCheck vdate}}
			<tr class="text-center tr-today">
				<td>{{vdate}}</td>
				<td>{{vhour}}</td>
				<td>{{vnum}}</td>
				<td>{{gubunCheck gubun}}</td>
				<td>
					<table class="text-center">
						<tr class="tr-today">
							<td class="team">{{home}}</td>
							<td class="score" nowrap>{{homescore}} : {{awayscore}}</td>
							<td class="team">{{away}}</td>
						</tr>
					</table>
				</td>
				<td>{{scode}}</td>
				<td>{{broad}}</td>
				<td>{{round}}</td>
			</tr>
		{{else}}
			<tr class="text-center">
				<td>{{vdate}}</td>
				<td>{{vhour}}</td>
				<td>{{vnum}}</td>
				<td>{{gubunCheck gubun}}</td>
				<td>
					<table class="text-center">
						<tr>
							<td class="team">{{home}}</td>
							<td class="score" nowrap>{{homescore}} : {{awayscore}}</td>
							<td class="team">{{away}}</td>
						</tr>
					</table>
				</td>
				<td>{{scode}}</td>
				<td>{{broad}}</td>
				<td>{{round}}</td>
			</tr>
		{{/todayCheck}}
	{{/each}}
</table>
</script>
<script>
	$(function(){
		function scheduleList(){
			let season=$('#season').val();
			let gubun=$('#gubun').val();
			let round=$('#round').val();
			let vdate=$('#vdate').val();
			let sort=$('#sort').val();
			let check=$('#check').val();
			const date=new Date();
			let year=date.getYear();
			let month=new String(date.getMonth()+1);
			if (check=='0'){
				year=year>=100?year-100:year;
				if(month<6){
					year=year-1;
				}
				if(month>4&&month<10){
					month='03';
				}
				if(month.length==1){
					month='0'+month;
				}
				season=year+''+(year+1);
				gubun='0';
				vdate=month;
				sort='vdate';
			}
			$.ajax({
				type:'get',
				url:'${path}/vleague/scheduleList',
				data:{season,gubun,round,vdate,sort},
				dataType:'json', //돌려받는 데이터 형
				success:function(result){
					Handlebars.registerHelper('gubunCheck',function(gubun){
						if(gubun=='1'){
							return '남자부';
						}else{
							return '여자부';
						}
					});
					Handlebars.registerHelper('todayCheck',function(vdate,options){
						year=date.getFullYear();
						if(month.length==1){
							month='0'+month;
						}
						let day=date.getDate();
						let today=year+'-'+month+'-'+day;
						console.log(today);
						if(vdate==today){
							return options.fn(this);
						}else{
							return options.inverse(this);
						}
					});
					var source=$('#template_source3').html();
					var template=Handlebars.compile(source);
					$('#scheduleList').html(template(result));
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		}
		
		$('#sort').on('change',function(){
			const value=$(this).val();
			console.log(value);
			var source=null;
			if(value=='vdate'){
				source=$('#template_source').html();
			}else{
				source=$('#template_source2').html();
			}
			var template=Handlebars.compile(source);
			$('#sortSub').html(template());
		});
		
		$('#btnList').on('click',function(e){
			e.preventDefault();
			$('#check').val('1');
			scheduleList();
		});
		
		scheduleList();
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
	<div class="container">
		<h2>V리그 일정 및 결과</h2>
		<input type="hidden" id="check" value="0">
		<select id="season" name="season">
			<option value="2021">도드람 2020-2021 V-리그</option>
		</select><br>
		<select id="gubun" name="gubun">
			<option value="0">전체</option>
			<option value="1">남자부</option>
			<option value="2">여자부</option>
		</select>
		<select id="sort" name="sort">
			<option value="round">라운드</option>
			<option value="vdate">년월</option>
		</select>
		<span id="sortSub">
			<select id="round" name="round">
				<option value="1">1라운드</option>
				<option value="2">2라운드</option>
				<option value="3">3라운드</option>
				<option value="4">4라운드</option>
				<option value="5">5라운드</option>
				<option value="6">6라운드</option>
				<option value="7">포스트시즌</option>
			</select>
		</span>
		<button id="btnList" class="btn-custom">조회</button>
		<button id="btnAdmin" class="btn-custom">관리자</button>
		<hr>
		<div id="scheduleList">
		
		</div>
	</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>