<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script type="text/javascript">
	$(function() {
		//파일추가
		$('#btnFileAdd').on('click',function(e){
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
		
		//등록버튼 클릭했을때
		$('#btnAdd').on('click',function(e){
			e.preventDefault();
			const subject=frmBrdAdd.subject.value;
			const content=frmBrdAdd.content.value;
			if(subject==''){
				alert('제목을 입력해주세요');
				frmBrdAdd.subject.focus();
				return ;
			}else if(content==''){
				alert('내용을 입력해주세요');
				frmBrdAdd.content.focus();
				return ;
			}
			//form의 속성 변경
			$('#frmBrdAdd').attr('action','${path}/board/add');
			$('#frmBrdAdd').attr('method','post');
			$('#frmBrdAdd').attr('enctype','multipart/form-data');
			$('#frmBrdAdd').submit();
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
		<h2>글쓰기</h2>
		<form id="frmBrdAdd" name="frmBrdAdd" class="frmBrd topmargin-board">
			<table border="1" class="tblBrd">
				<tr>
					<th class="text-right thBrd">제목</th>
					<td class="tdBrd"><input type="text" name="subject" id="subject" class="input-board"></td>
				</tr>
				<tr>
					<th valign="top" class="text-right thBrd">내용</th>
					<td class="tdBrd"><textarea rows="10" name="content" id="content" class="input-board"></textarea></td>
				</tr>
				<tr>
					<th valign="top" class="text-right thBrd">파일</th>
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
									<a id="btnFileAdd" class="icon-plus"><i class="far fa-plus-square"></i></a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table class="topmargin">
				<tr>
					<td align="center">
						<button id="btnAdd" class="btn-primary">등록</button>
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