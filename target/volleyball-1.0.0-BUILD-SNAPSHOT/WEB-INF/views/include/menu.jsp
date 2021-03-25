<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script type="text/javascript">
	//주소찾기 팝업 함수
	function goPopup(){
		var pop = window.open("${path}/member/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
	}
	
	//주소팝업에서 실행할 함수
	function jusoCallBack(roadAddrPart1,addrDetail,zipNo){
		frmAdd.addr1.value = roadAddrPart1;
		frmAdd.addr2.value = addrDetail;
		frmAdd.zip.value = zipNo;
	}
</script>
<script type="text/javascript">
	$(function() {
		//로그인
		$('#btnLogin').on('click', function(e) {
			//아이디/패스워드 체크
			e.preventDefault(); //객체의 기본기능을 소멸
			var userid = frmLogin.userid.value;
			var passwd = frmLogin.passwd.value;
			if (userid == ''){
				alert('아이디를 입력해 주세요!');
				frmLogin.userid.focus();
			}else if (passwd == ''){
				alert('패스워드를 입력해 주세요!');
				frmLogin.passwd.focus();
			}else{
				$('#loginForm').attr('action','${path}/login');
				$('#loginForm').attr('method','post');
				$('#loginForm').submit();
			}
		});
		
		//아이디 중복 체크
		$('#btnIdCheck').click(function(){
			//alert('dd');
			const userid=frmAdd.userid.value;
			console.log(userid);
			if(userid==''){
				alert('아이디를 입력해 주세요');
				frmAdd.userid.focus();
				return ;
			}
			$.ajax({
				type: 'post',
				url: '${path}/member/idCheck',
				data: {userid:userid},
				dataType: 'json',
				success: function(result){
					alert(result.msg);
					//alert(result.yn);
					if (result.yn=='y'){
						frmAdd.idCheckYn.value='y';
						console.log(frmAdd.idCheckYn.value);
					}else{
						frmAdd.idCheckYn.value='n';
					}
				},
				error: function(result){
					alert('error');
				}
			});
		});
		
		//userid change 이벤트
		$('#userid').change(function(){
			$('#idCheckYn').val('n'); //중복체크 해제
		});
		
		//주소찾기 버튼 눌렀을 때(주소api)
		$('#btnAddrFind').click(function(e){
			e.preventDefault();
			goPopup();
		});
		
		//가입버튼을 클릭했을 때
		$('#btnAdd').on('click',function(e){
			e.preventDefault(); //기본이벤트 제거
			const userid=frmAdd.userid.value;
 			const passwd=frmAdd.passwd.value;
			const email=frmAdd.email.value;
			console.log(userid);
 			console.log(passwd);
			console.log(email);
			if(userid==''){
				alert('아이디를 입력해주세요');
				frmAdd.userid.focus();
			}else if(passwd==''){
				alert('비밀번호를 입력해주세요');
				frmAdd.passwd.focus();
			}else if(email==''){
				alert('이메일을 입력해주세요');
				frmAdd.email.focus();
			}else if(frmAdd.idCheckYn.value!='y'){
				alert('아이디 중복 확인해주세요');
				$('#btnIdCheck').focus();
			}else{
				frmAdd.submit();
			}
		});
		
		//로그아웃
		$('#aLogout').on('click', function(e) {
			e.preventDefault(); //객체의 기본기능을 소멸
			var result = confirm('로그아웃 하시겠습니까?');
			if (result){
				$(location).attr('href', '${path}/logout');
			}
		});

	});
</script>
<nav class="navbar navbar-custom">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${path}/">VB포럼</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${path}/">Home</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">V-League <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${path}/vleague/schedule">일정 및 결과</a></li>
            <li><a href="#">순위표</a></li>
            <li><a href="${path}/vleague/stadium">경기장</a></li>
          </ul>
        </li>
        <li><a href="${path}/onair/">OnAir</a></li>
        <li><a href="${path}/board/">Board</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<c:if test="${sessionScope.userid==null}">
	        <li><a href="#" id="aSignUp" data-toggle="modal" data-target="#signupModal"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
	        <li><a href="#" id="aLogin" data-toggle="modal" data-target="#loginModal"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:if>
        <c:if test="${sessionScope.userid!=null}">
	        <li><a href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.userid}</a></li>
	        <li><a href="" id="aLogout">Logout <span class="glyphicon glyphicon-log-out"></span></a></li>
        </c:if>
      </ul>
    </div>
    
    <!-- Modal(Login) -->
	<div class="modal fade" id="loginModal" role="dialog">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">로그인</h4>
	      </div>
	      <div class="modal-body">
	        <form id ="loginForm" name="frmLogin">
			  	<div class="input-group">
			    	<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
			    	<input type="text" class="form-control" name="userid" placeholder="Id">
			  	</div>
			  	<div class="input-group">
			    	<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			    	<input type="password" class="form-control" name="passwd" placeholder="Password">
			  	</div>
			</form>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary btnModal" id="btnLogin">로그인</button><br>
			<button type="button" class="btn btn-info btnModal" id="btnJoin" data-toggle="modal" data-target="#signupModal">회원가입</button><br>
			<button type="button" class="btn btn-default btnModal" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
    <!-- Modal(Sign Up) -->
	<div class="modal fade" id="signupModal" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">회원가입</h4>
	      </div>
	      <div class="modal-body">
			<form name="frmAdd" action="${path}/member/add" method="post" enctype="multipart/form-data">
				<table id="tblAdd">
					<tr>
						<th class="text-right thAdd">아이디</th>
						<td class="tdAdd">
							<input type="text" name="userid" size="10" id="userid"> 
							<input type="hidden" name="idCheckYn"><!-- value가 y이면 체크 완료 -->
							<input type="button" value="중복체크" id="btnIdCheck">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">비밀번호</th>
						<td class="tdAdd"><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<th class="text-right thAdd">이메일</th>
						<td class="tdAdd"><input type="email" name="email"></td>
					</tr>
					<tr>
						<th rowspan="3" class="text-right thAdd">주소</th>
						<td class="tdAdd">
							<input type="text" name="zip" maxlength="5" size="5" placeholder="우편번호"> 
							<button id="btnAddrFind">주소찾기</button>
						</td>
					</tr>
					<tr>
						<td class="tdAdd"><input type="text" name="addr1" size="30" placeholder="주소"></td>
					</tr>
					<tr>
						<td class="tdAdd"><input type="text" name="addr2" size="30" placeholder="상세주소"></td>
					</tr>
					<tr>
						<th class="text-right thAdd">이미지파일</th>
						<td class="tdAdd"><input type="file" name="imgfile" accept="image/*"></td>
					</tr>
				</table>
			</form>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary btnModal" id="btnAdd">회원가입</button><br>
			<button type="button" class="btn btn-default btnModal" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
  </div>
</nav>
