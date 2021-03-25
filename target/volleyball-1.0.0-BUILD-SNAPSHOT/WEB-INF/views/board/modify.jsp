<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한건수정</title>
<script type="text/javascript">
	$(function() {
		//파일추가
		$('#btnFileAdd').on('click',function(e){
			e.preventDefault();
			var appendHtml='<li><input type="file" name="uploadfiles"><button class="btnFileRemove">삭제</button></li>';
			$('#fileGroup').append(appendHtml);
		});
		
		//파일삭제: 동적으로 생성된 버튼의 기능
		$('#fileGroup').on('click','button',function(e){
			e.preventDefault();
			//this 객체 자신
			$(this).parent().remove();
		});
		
		//수정버튼 클릭했을때
		$('#btnModify').on('click',function(e){
			e.preventDefault();
			const subject=frmModify.subject.value;
			const content=frmModify.content.value;
			if(subject==''){
				alert('제목을 입력해주세요');
				frmModify.subject.focus();
				return ;
			}else if(content==''){
				alert('내용을 입력해주세요');
				frmModify.content.focus();
				return ;
			}
			//form의 속성 변경
			$('#frmModify').attr('action','${path}/board/modify');
			$('#frmModify').attr('method','post');
			$('#frmModify').attr('enctype','multipart/form-data');
			$('#frmModify').submit();
		});
		
		$('#btnList').on('click',function(e){
			e.preventDefault();
			location.href='${path}/board/';
		});
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="container">
	<h2>게시물수정</h2>
	<form id="frmModify" name="frmModify">
		<input type="hidden" name="bnum" value="${bdto.bnum}">
		<table>
			<tr>
				<th>제목</th>
				<td colspan="2"><input type="text" name="subject" id="subject" size="50" value="${bdto.subject}"></td>
			</tr>
			<tr>
				<th valign="top">내용</th>
				<td colspan="2"><textarea rows="10" cols="52" name="content" id="content">${bdto.content}</textarea></td>
			</tr>
			<tr>
				<th rowspan="2" valign="top">파일</th>
				<td>
					<c:forEach var="file" items="${bflist}">
						${file.filename}<br>
					</c:forEach>
				</td>
				<td>
					<c:forEach var="file" items="${bflist}">
						<input type="checkbox" name="fileDelete" value="${file.fnum}">삭제<br>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td>
					<ul id="fileGroup">
						<li><input type="file" name="uploadfiles"><button class="btnFileRemove">삭제</button></li>
					</ul>
				</td>
				<td valign="top"><button id="btnFileAdd">추가</button></td>
			</tr>
			<tr>
				<td colspan="3" align="center">
					<button id="btnModify">수정</button>
					<input type="reset" value="취소">
					<button id="btnList">목록</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>