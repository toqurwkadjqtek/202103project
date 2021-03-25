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
		$('#modifyAddr1').val(roadAddrPart1);
		$('#modifyAddr2').val(addrDetail);
		$('#modifyZip').val(zipNo);
	}
</script>
<script type="text/javascript">
	$(function() {
		let mdto;
		
		//로그인
		function goLogin(){
			var userid = frmLogin.userid.value;
			var passwd = frmLogin.passwd.value;
			if (userid == ''){
				$('#loginMsg').html('*아이디를 입력해주세요');
				frmLogin.userid.focus();
			}else if (passwd==''){
				$('#loginMsg').html('*비밀번호를 입력해 주세요');
				frmLogin.passwd.focus();
			}else{
				$('#loginForm').attr('action','${path}/login');
				$('#loginForm').attr('method','post');
				$('#loginForm').submit();
			}
		}
		
		$('#btnLogin').on('click', function(e) {
			e.preventDefault();
			goLogin();
		});
		
		//아이디 중복 체크
		$('#btnIdCheck').click(function(){
			const userid=frmAdd.userid.value;
			console.log(userid);
			if(userid==''){
				$('#addMsg').html('*이메일을 입력해주세요');
				frmAdd.userid.focus();
				return ;
			}
			$.ajax({
				type: 'post',
				url: '${path}/member/idCheck',
				data: {userid},
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
		
		//가입 닉네임 중복 체크
		$('#btnNickCheckAdd').click(function(){
			const nickname=frmAdd.nickname.value;
			console.log(nickname);
			if(nickname==''){
				$('#addMsg').html('*닉네임을 입력해주세요');
				frmAdd.nickname.focus();
				return ;
			}
			$.ajax({
				type: 'post',
				url: '${path}/member/nickCheck',
				data: {nickname},
				dataType: 'json',
				success: function(result){
					alert(result.msg);
					//alert(result.yn);
					if (result.yn=='y'){
						frmAdd.nickCheckYn.value='y';
						console.log(frmAdd.nickCheckYn.value);
					}else{
						frmAdd.nickCheckYn.value='n';
					}
				},
				error: function(result){
					alert('error');
				}
			});
		});
		
		//수정 닉네임 중복 체크
		$('#btnNickCheckModify').click(function(){
			const nickname=frmModify.nickname.value;
			console.log(nickname);
			if(nickname==''){
				$('#addMsg').html('*닉네임을 입력해주세요');
				frmModify.nickname.focus();
				return ;
			}
			$.ajax({
				type: 'post',
				url: '${path}/member/nickCheck',
				data: {nickname},
				dataType: 'json',
				success: function(result){
					alert(result.msg);
					//alert(result.yn);
					if (result.yn=='y'){
						frmModify.nickCheckYn.value='y';
						console.log(frmModify.nickCheckYn.value);
					}else{
						frmModify.nickCheckYn.value='n';
					}
				},
				error: function(result){
					alert('error');
				}
			});
		});
		
		function apwCheck(){
			let pw1=$('#apw1').val();
			let pw2=$('#apw2').val();
			if(pw1==pw2){
				$('#pwCheckYnAdd').val('y');
			}else{
				$('#pwCheckYnAdd').val('n');
			}
		}
		
		//비밀번호 일치 체크(Add)
		$('#apw1').on('change',function(){
			apwCheck();
		});
		$('#apw2').on('change',function(){
			apwCheck();
		});
		
		function mpwCheck(){
			let pw1=$('#mpw1').val();
			let pw2=$('#mpw2').val();
			if(pw1==pw2){
				$('#pwCheckYnModify').val('y');
			}else{
				$('#pwCheckYnModify').val('n');
			}
		}
		
		//비밀번호 일치 체크(Modify)
		$('#mpw1').on('change',function(){
			mpwCheck();
		});
		$('#mpw2').on('change',function(){
			mpwCheck();
		});
		
		//userid change 이벤트
		$('#userid').change(function(){
			$('#idCheckYn').val('n'); //중복체크 해제
		});
		
		//nickname change 이벤트
		$('#nickname').change(function(){
			$('#nickCheckYnAdd').val('n'); //중복체크 해제
		});
		$('#modifyNickname').change(function(){
			$('#nickCheckYnModify').val('n'); //중복체크 해제
			if($('#modifyNickname').val()==mdto.nickname){
				$('#nickCheckYnModify').val('y');
			}
		});
		
		//주소찾기 버튼 눌렀을 때(주소api)
		$('.btnAddrFind').click(function(e){
			e.preventDefault();
			goPopup();
		});
		
		//가입버튼을 클릭했을 때
		$('#btnMemAdd').on('click',function(e){
			e.preventDefault();
			const userid=frmAdd.userid.value;
 			const passwd=frmAdd.passwd.value;
			const nickname=frmAdd.nickname.value;
			console.log(userid);
 			console.log(passwd);
			console.log(nickname);
			if(userid==''){
				$('#addMsg').html('*이메일을 입력해주세요');
				frmAdd.userid.focus();
			}else if(nickname==''){
				$('#addMsg').html('*닉네임을 입력해주세요');
				frmAdd.nickname.focus();
			}else if(passwd==''){
				$('#addMsg').html('*비밀번호를 입력해주세요');
				frmAdd.passwd.focus();
			}else if(frmAdd.idCheckYn.value!='y'){
				$('#addMsg').html('*이메일 중복 확인해주세요');
				$('#btnIdCheck').focus();
			}else if(frmAdd.nickCheckYn.value!='y'){
				$('#addMsg').html('*닉네임 중복 확인해주세요');
				$('#btnNickCheckAdd').focus();
			}else if(frmAdd.pwCheckYn.value!='y'){
				$('#addMsg').html('*비밀번호가 일치하지 않습니다');
				$('#apw2').focus();
			}else{
				frmAdd.submit();
			}
		});
		
		//로그아웃
		$('#aLogout').on('click', function(e) {
			e.preventDefault();
			var result = confirm('로그아웃 하시겠습니까?');
			if(result){
				$(location).attr('href','${path}/logout');
			}
		});
		
		//내정보
		$('#aInfo').on('click', function() {
			$.ajax({
				type: 'get',
				url: '${path}/member/info',
				dataType: 'json',
				success: function(result){
					mdto=result
					let addr;
					if(result.zip!=''){
						addr='('+result.zip+') '+result.addr1+' '+result.addr2;
					}
					$('#infoUserid').html(result.userid);
					$('#infoNickname').html(result.nickname);
					$('#infoAddr').html(addr);
					$('#infoFilename').html(result.filename);
				},
				error: function(result){
					alert('error');
				}
			});
		});
		
		//내정보의 수정버튼 눌렀을 때 수정폼으로
		$('#btnModifyForm').on('click',function(e){
			e.preventDefault();
			$('#modifyUserid').html(mdto.userid);
			$('#modifyNickname').val(mdto.nickname);
			$('#modifyZip').val(mdto.zip);
			$('#modifyAddr1').val(mdto.addr1);
			$('#modifyAddr2').val(mdto.addr2);
			$('modifyFilename').prepend(mdto.filename);
			$('#infoModal').modal('hide');
			$('#modifyModal').modal('show');
		});
		
		//내정보수정의 수정버튼을 클릭했을 때
		$('#btnMemModify').on('click',function(e){
			e.preventDefault();
			const userid='${sessionScope.userid}';
 			const passwd=frmModify.passwd.value;
			const nickname=frmModify.nickname.value;
 			console.log(passwd);
			console.log(nickname);
			if(nickname==''){
				$('#modifyMsg').html('*닉네임을 입력해주세요');
				frmModify.nickname.focus();
			}else if(frmModify.nickCheckYn.value!='y'){
				$('#modifyMsg').html('*닉네임 중복 확인해주세요');
				$('#btnNickCheckAdd').focus();
			}else if(frmModify.pwCheckYn.value!='y'){
				$('#modifyMsg').html('*비밀번호가 일치하지 않습니다');
				$('#mpw2').focus();
			}else{
				frmModify.submit();
			}
		});
		
		//내정보수정의 닫기버튼 눌렀을 때 내정보로
		$('#btnGoInfo').on('click',function(e){
			e.preventDefault();
			const userid='${sessionScope.userid}';
			$.ajax({
				type: 'get',
				url: '${path}/member/reSession',
				data: {userid},
				dataType: 'text',
				success: function(result){
					console.log(result);
				},
				error: function(result){
					alert('error');
				}
			});
			$('#modifyModal').modal('hide');
			$('#aInfo').trigger('click');
		});
		
		//탈퇴버튼 눌렀을 때
		$('#btnMemDel').on('click',function(e){
			e.preventDefault();
			if(confirm('정말 탈퇴하시겠습니까?')){
				location.href='${path}/member/delete';
			}
		});
		
		$('#loginUserid').on('keydown',function(e){
       		if(e.keyCode==13){
       			$('#loginPasswd').val('');
       			$('#loginPasswd').focus();
       		}
        });
		
		$('#loginPasswd').on('keydown',function(key){
       		if(key.keyCode==13){
       			goLogin();
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
      <ul class="nav navbar-nav"><li class="active"><a class="navbar-brand" href="${path}/">VB포럼</a></li></ul>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="${path}/">Home</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">V-League <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${path}/vleague/schedule">일정 및 결과</a></li>
            <!-- <li><a href="#">순위표</a></li> -->
            <li><a href="${path}/vleague/stadium">경기장</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">OnAir <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${path}/onair/men">남자배구</a></li>
            <li><a href="${path}/onair/women">여자배구</a></li>
            <li><a href="${path}/onair/sample">Sample</a></li>
          </ul>
        </li>
        <li><a href="${path}/board/">Board</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<c:if test="${sessionScope.userid==null}">
	        <!-- <li><a href="#" id="aSignUp" data-toggle="modal" data-target="#signupModal"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li> -->
	        <li><a href="#" id="aLogin" data-toggle="modal" data-target="#loginModal"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:if>
        <c:if test="${sessionScope.userid!=null}">
	        <li><a href="#" id="aInfo" data-toggle="modal" data-target="#infoModal"><span class="glyphicon glyphicon-user"></span> ${sessionScope.nickname}</a></li>
	        <li><a href="" id="aLogout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
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
			    	<input type="text" class="form-control" name="userid" id="loginUserid" placeholder="Id">
			  	</div>
			  	<div class="input-group">
			    	<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			    	<input type="password" class="form-control" name="passwd" id="loginPasswd" placeholder="Password">
			  	</div>
			</form>
			<div id="loginMsg" class="checkMsg"></div>
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
				<table class="tblAdd">
					<tr>
						<th class="text-right thAdd">* 이메일</th>
						<td class="tdAdd">
							<input type="email" name="userid" id="userid"> 
							<input type="hidden" name="idCheckYn" id="idCheckYn"><!-- value가 y이면 체크 완료 -->
							<input type="button" value="중복확인" id="btnIdCheck">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 닉네임</th>
						<td class="tdAdd">
							<input type="text" name="nickname" size="10" id="nickname">
							<input type="hidden" name="nickCheckYn" id="nickCheckYnAdd"><!-- value가 y이면 체크 완료 -->
							<input type="button" value="중복확인" id="btnNickCheckAdd">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 비밀번호</th>
						<td class="tdAdd">
							<input type="hidden" name="pwCheckYn" id="pwCheckYnAdd">
							<input type="password" name="passwd" id="apw1">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 비밀번호 확인</th>
						<td class="tdAdd"><input type="password" name="passwd2" id="apw2"></td>
					</tr>
					
					<tr>
						<th rowspan="3" class="text-right thAdd">주소</th>
						<td class="tdAdd">
							<input type="text" name="zip" maxlength="5" size="5" placeholder="우편번호"> 
							<button class="btnAddrFind">주소찾기</button>
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
				<div id="addMsg" class="checkMsg"></div>
			</form>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary btnModal" id="btnMemAdd">회원가입</button><br>
			<button type="button" class="btn btn-default btnModal" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
    <!-- Modal(Info) -->
	<div class="modal fade" id="infoModal" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content" id="infoModify">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">내 정보</h4>
	      </div>
	      <div class="modal-body">
			<table class="tblAdd">
				<tr>
					<th class="text-right thAdd">아이디</th>
					<td class="tdAdd" id="infoUserid"></td>
				</tr>
				<tr>
					<th class="text-right thAdd">닉네임</th>
					<td class="tdAdd" id="infoNickname"></td>
				</tr>
				<tr>
					<th class="text-right thAdd">주소</th>
					<td class="tdAdd" id="infoAddr"></td>
				</tr>
				<tr>
					<th class="text-right thAdd">파일</th>
					<td class="tdAdd" id="infoFilename"></td>
				</tr>
			</table>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary btnModal" id="btnModifyForm">수정</button><br>
			<button type="button" class="btn btn-info btnModal" id="btnMemDel">탈퇴</button><br>
			<button type="button" class="btn btn-default btnModal" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>

    <!-- Modal(Modify) -->
	<div class="modal fade" id="modifyModal" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">내 정보 수정</h4>
	      </div>
	      <div class="modal-body">
			<form name="frmModify" action="${path}/member/modify" method="post" enctype="multipart/form-data">
				<input type="hidden" name="userid" value="${sessionScope.userid}">
				<table class="tblAdd">
					<tr>
						<th class="text-right thAdd">* 이메일</th>
						<td class="tdAdd" id="modifyUserid"></td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 닉네임</th>
						<td class="tdAdd">
							<input type="text" name="nickname" size="10" id="modifyNickname">
							<input type="hidden" name="nickCheckYn" id="nickCheckYnModify" value="y"><!-- value가 y이면 체크 완료 -->
							<input type="button" value="중복확인" id="btnNickCheckModify">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 새 비밀번호</th>
						<td class="tdAdd">
							<input type="hidden" name="pwCheckYn" id="pwCheckYnModify" value="y">
							<input type="password" name="passwd" id="mpw1">
						</td>
					</tr>
					<tr>
						<th class="text-right thAdd">* 비밀번호 확인</th>
						<td class="tdAdd"><input type="password" name="passwd2" id="mpw2"></td>
					</tr>
					
					<tr>
						<th rowspan="3" class="text-right thAdd">주소</th>
						<td class="tdAdd">
							<input type="text" name="zip" maxlength="5" size="5" id="modifyZip" placeholder="우편번호"> 
							<button class="btnAddrFind">주소찾기</button>
						</td>
					</tr>
					<tr>
						<td class="tdAdd"><input type="text" name="addr1" size="30" id="modifyAddr1" placeholder="주소"></td>
					</tr>
					<tr>
						<td class="tdAdd"><input type="text" name="addr2" size="30" id="modifyAddr2" placeholder="상세주소"></td>
					</tr>
					<tr>
						<th class="text-right thAdd">이미지파일</th>
						<td class="tdAdd" id="modifyFilename"></td>
					</tr>
					<tr>
						<th class="text-right thAdd">변경 이미지파일</th>
						<td class="tdAdd"><input type="file" name="imgfile" id="modifyImgfile" accept="image/*"></td>
					</tr>
				</table>
				<div id="modifyMsg" class="checkMsg"></div>
			</form>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary btnModal" id="btnMemModify">수정</button><br>
			<button type="button" class="btn btn-default btnModal" data-dismiss="modal" id="btnGoInfo">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>

  </div>
</nav>
