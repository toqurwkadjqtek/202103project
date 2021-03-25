<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<script type="text/javascript">
	$(function(){
		
		//주소찾기 버튼 눌렀을 때(주소api)
		$('#btnAddrFind').click(function(e){
			e.preventDefault();
			goPopup();
		});
		
		//파일삭제버튼
		$('#btnFileDelete').click(function(e){
			e.preventDefault();
			location.href='${path}/main';
		});
		
		//가입버튼을 클릭했을 때
		$('#btnAdd').on('click',function(e){
			e.preventDefault(); //기본이벤트 제거
 			const oldPasswd=frmAdd.oldPasswd.value;
			const email=frmAdd.email.value;
 			console.log(oldPasswd);
			console.log(email);
			if(oldPasswd==''){
				alert('기존 비밀번호를 입력해주세요');
				frmAdd.passwd.focus();
			}else if(email==''){
				alert('이메일 입력해주세요');
				frmAdd.email.focus();
			}else{
				frmAdd.submit();
			}
		});
		
		//메인버튼
		$('#btnMain').click(function(e){
			e.preventDefault();
			location.href='${path}/main';
		});
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="container">
	<h2>수정폼</h2>
	<form name="frmAdd" action="${path}/member/modify" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="hidden" name="userid" value="${mdto.userid}">${mdto.userid}
				</td>
			</tr>
			<tr>
				<th>기존 비밀번호</th>
				<td><input type="password" name="oldPasswd"></td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" name="email" value="${mdto.email}"></td>
			</tr>
			<tr>
				<th rowspan="3">주소</th>
				<td>
					<input type="text" name="zip" maxlength="5" size="5" placeholder="우편번호"  value="${mdto.zip}"> 
					<button id="btnAddrFind">주소찾기</button>
				</td>
			</tr>
			<tr>
				<td><input type="text" name="addr1" size="30" placeholder="주소"  value="${mdto.addr1}"></td>
			</tr>
			<tr>
				<td><input type="text" name="addr2" size="30" placeholder="상세주소" value="${mdto.addr2}"></td>
			</tr>
			<c:if test="${mdto.filename==null}">
				<tr>
					<th>파일</th>
					<td><input type="file" name="imgfile"></td>
				</tr>
			</c:if>
			<c:if test="${mdto.filename!=null}">
				<tr>
					<th rowspan="2">파일</th>
					<td>${mdto.filename}</td>
				</tr>
				<tr>
					<td><input type="file" name="imgfile"></td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2" align="center">
					<button id="btnModify">수정</button>
					<input type="reset" value="취소">
					<button id="btnMain">메인</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>