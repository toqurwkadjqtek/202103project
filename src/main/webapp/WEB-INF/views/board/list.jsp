<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="template_source" type="text/x-handlebars-template">
	<table border="1" class="table-hover table-bordered">
		<thead>
			<tr>
				<th class="text-center">번호</th>
				<th class="text-center">제목</th>
				<th class="text-center">작성자</th>
				<th class="text-center" width="7%">조회수</th>
				<th class="text-center" width="7%">추천수</th>
				<th class="text-center" width="20%">등록일</th>
			</tr>
		</thead>
		{{#each.}}
		<tr>
			<td class="text-center">{{bnum}}</td>
			<td><a href="${path}/board/detail/{{bnum}}">{{subject}}</a></td>
			<td class="text-center">{{nickname}}</td>
			<td class="text-center">{{readcount}}</td>
			<td class="text-center">{{likecnt}}</td>
			<td class="text-center">{{regdate}}</td>
		</tr>
		{{/each}}
	</table>
</script>
<script type="text/javascript">
	$(function(){
		//조회,하이퍼링크 클릭했을때 처리할 함수
		function pageList(curPage){ //현재페이지 매개변수로
			const findKey=frmList.findKey.value;
			const findValue=frmList.findValue.value;
			console.log(findKey);
			console.log(findValue);
			console.log('curPage:'+curPage);
			const sessionCurPage=${sessionScope.pdto.getCurPage()};
			console.log(sessionCurPage);
 			if(curPage==null){
				curPage=sessionCurPage;
			}
			
			//ajax 비동기 방식
			$.ajax({
				type:'get',
				url:'${path}/board/list/',
				data:{findKey,findValue,curPage},
				dataType:'json', //돌려받는 데이터 형
				success:function(result){
					console.log(result);
					var source=$('#template_source').html();
					var template=Handlebars.compile(source);
					$('#boardList').html(template(result.blist));
					
					const pdto=result.pdto; //페이징 정보
					//페이징 처리
					$('#paging').html(''); //초기화
					if(pdto.startPage!=1){
						$('#paging').append('<li><a class="aPage" href="'+(pdto.startPage-1)+'">prev</a></li>');
					}
					for(var i=pdto.startPage;i<pdto.endPage+1;i++){
						if(i==curPage){
							$('#paging').append('<li class="active"><a class="aPage" href="'+i+'">'+i+'</a></li>');
						}else{
							$('#paging').append('<li><a class="aPage" href="'+i+'">'+i+'</a></li>');
						}
					}
					if(pdto.endPage<pdto.totPage){
						$('#paging').append('<li><a class="aPage" href="'+(pdto.endPage+1)+'">next</a></li>');
					}
					
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		}
		
		//조회버튼 클릭시 첫페이지 보이기
		$('#btnList').on('click',function(e){
			e.preventDefault();
			pageList(1);
		});
		
		//페이지를 클릭했을 때
		$('#paging').on('click','.aPage',function(e){
			e.preventDefault(); //a태그라서 갔다오느라 화면 깜박이는거 중지
			const pageNo=$(this).attr('href');
			pageList(pageNo);
		});
		
		//게시글 추가폼으로
		$('#btnBrdAdd').on('click',function(e){
			e.preventDefault();
			location.href='${path}/board/add';
		});
		
		$('#findValue').on('keydown',function(e){
       		if(e.keyCode==13){
       			$('#btnList').on('click',function(e){
       				e.preventDefault();
       				pageList(1);
       			});
       		}
        });
		
		//$('#btnList').trigger('click'); //강제로 click 이벤트 발생
		pageList();
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="container">
	<div class="topmargin">
	<h2>Board</h2>
	<form name="frmList" action="" class="box-right">
		<select name="findKey">
			<option value="nickname">작성자</option>
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="subcon">제목+내용</option>
		</select>
		<input type="text" id="findValue" name="findValue">
		<button id="btnList">조회</button>
		<c:if test="${sessionScope.userid!=null}">
			<button id="btnBrdAdd">글쓰기</button>
		</c:if>
	</form>
	</div>
	<div id="boardList"></div>
	<div class="text-center"><ul id="paging" class="pagination-custom"></ul></div>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>