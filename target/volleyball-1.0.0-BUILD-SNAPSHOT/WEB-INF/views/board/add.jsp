<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물추가</title>
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
		
		//등록버튼 클릭했을때
		$('#btnAdd').on('click',function(e){
			e.preventDefault();
			const subject=frmAdd.subject.value;
			const content=frmAdd.content.value;
			if(subject==''){
				alert('제목을 입력해주세요');
				frmAdd.subject.focus();
				return ;
			}else if(content==''){
				alert('내용을 입력해주세요');
				frmAdd.content.focus();
				return ;
			}
			//form의 속성 변경
			$('#frmAdd').attr('action','${path}/board/add');
			$('#frmAdd').attr('method','post');
			$('#frmAdd').attr('enctype','multipart/form-data');
			$('#frmAdd').submit();
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
	<h2>게시물추가</h2>
	<form id="frmAdd" name="frmAdd">
		<table>
			<tr>
				<th>제목</th>
				<td colspan="2"><input type="text" name="subject" id="subject" size="50"></td>
			</tr>
			<tr>
				<th valign="top">내용</th>
				<td colspan="2"><textarea rows="10" cols="52" name="content" id="content"></textarea></td>
			</tr>
			<tr>
				<th valign="top">파일</th>
				<td>
					<ul id="fileGroup">
						<li><input type="file" name="uploadfiles"><button class="btnFileRemove">삭제</button></li>
					</ul>
				</td>
				<td valign="top"><button id="btnFileAdd">추가</button></td>
			</tr>
			<tr>
				<td colspan="3" align="center">
					<button id="btnAdd">등록</button>
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