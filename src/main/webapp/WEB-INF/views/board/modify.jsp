<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<script type="text/javascript">
	$(function() {
		//파일추가
		$('#btnFileAddM').on('click',function(e){
			e.preventDefault();
			var appendHtml='<span><input type="file" name="uploadfiles"><a class="btnFileRemove icon-minus"><i class="far fa-minus-square"></i></a></span>';
			$('#fileGroup').append(appendHtml);
		});
		
		//파일삭제: 동적으로 생성된 버튼의 기능
		$('#fileGroup').on('click','a',function(e){
			e.preventDefault();
			//this 객체 자신
			$(this).parent().remove();
		});
		
		//수정버튼 클릭했을때
		$('#btnModify').on('click',function(e){
			e.preventDefault();
			const subject=frmBrdModify.subject.value;
			const content=frmBrdModify.content.value;
			if(subject==''){
				alert('제목을 입력해주세요');
				frmBrdModify.subject.focus();
				return ;
			}else if(content==''){
				alert('내용을 입력해주세요');
				frmBrdModify.content.focus();
				return ;
			}
			//form의 속성 변경
			$('#frmBrdModify').attr('action','${path}/board/modify');
			$('#frmBrdModify').attr('method','post');
			$('#frmBrdModify').attr('enctype','multipart/form-data');
			$('#frmBrdModify').submit();
		});
		
		$('#btnList').on('click',function(e){
			e.preventDefault();
			location.href='${path}/board/list';
		});
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="container">
	<div class="maxwidth-board">
		<h2>글수정</h2>
		<form id="frmBrdModify" name="frmBrdModify" class="frmBrd topmargin-board">
			<input type="hidden" name="bnum" value="${bdto.bnum}">
			<table border="1" class="tblBrd">
				<tr>
					<th class="text-right thBrd">제목</th>
					<td class="tdBrd"><input type="text" name="subject" id="subject" class="input-board" value="${bdto.subject}"></td>
				</tr>
				<tr>
					<th valign="top" class="text-right thBrd">내용</th>
					<td class="tdBrd"><textarea rows="10" name="content" id="content" class="input-board">${bdto.content}</textarea></td>
				</tr>
				<tr>
					<th valign="top" class="text-right thBrd">파일</th>
					<td class="tdBrd">
						<table>
							<tr>
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
						</table>
					</td>
				</tr>
				<tr>
					<th valign="top" class="text-right thBrd">추가파일</th>
					<td class="tdBrd">
						<table class="tblFile">
							<tr>
								<td class="tdFile">
			 						<div id="fileGroup">
										<span>
										    	<input type="file" name="uploadfiles">
										</span>
									</div>
								</td>
								<td class="tdFilePlus">
									<a id="btnFileAddM" class="icon-plus"><i class="far fa-plus-square"></i></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table class="topmargin">
				<tr>
					<td align="center">
						<button id="btnModify" class="btn-primary">수정</button>
						<button id="btnList" class="btn-custom">목록</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>