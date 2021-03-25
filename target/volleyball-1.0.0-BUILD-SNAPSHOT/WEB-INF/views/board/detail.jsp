<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세조회</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="template_replylist" type="text/x-handlebars-template">
	{{#each.}}
		<div>
		<table width="100%">
			<tr>
				<td valign="top" align="right"><div class="vl"></div><div class="opa">{{level relevel}}</div></td>
				<td>
					<table width="100%"><tr><td>
					<table width="100%">
						<tr>
							<td colspan="2">
								<input type="hidden" class="restep" value="{{restep}}">
								<input type="hidden" class="relevel" value="{{relevel}}">
								<input type="hidden" class="rnum" value="{{rnum}}">
							</td>
						</tr>
						<tr>
							<td><i class="far fa-comment-dots"></i>&nbsp;<b class="userid">{{userid}}</b></td>
							<td align="right">
								<a class="aLike" href=""><i class="far fa-thumbs-up"></i><span class="relikecnt">{{likecnt}}</span></a>&nbsp;&nbsp;
								<a class="aDisLike" href=""><i class="far fa-thumbs-down"></i><span class="redislikecnt">{{dislikecnt}}</span></a>&nbsp;
								{{regdate}} 
								{{#useridCheck userid}}
									<button class="btnReplyUpdate btn-custom">수정</button>
									<button class="btnReplyDelete btn-custom">삭제</button>
								{{/useridCheck}}
								<c:if test="${sessionScope.userid!=null}">
									<button class="btnReply btn-custom">댓글</button>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="modifyForm"><span class="content">{{content}}</span></td>
						</tr>
						<tr>
							<td colspan="2" class="replyForm"></td>
						</tr>
					</table>
					</td></tr></table><br>
				</td>
			</tr>
		</table>
		</div>
	{{/each}}
</script>
<script id="template_source2" type="text/x-handlebars-template">
	<table width="100%">
		<tr>
			<td style="width:90%;">
				<input type="hidden" class="replyflag" value="0">
				<input type="hidden" class="replyrestep">
				<input type="hidden" class="replyrelevel"><br>
				<textarea rows="5" style="width:100%;" class="replycontent"></textarea>
			</td>
			<td align="center"><button class="btnReplyAdd btn-custom">댓글등록</button></td>
		</tr>
	</table>
</script>
<script id="template_modify1" type="text/x-handlebars-template">
	<table width="100%">
		<tr>
			<td style="width:90%;" class="modifyContent">
				<input type="hidden" class="modifyflag" value="0">
				<input type="hidden" class="savecontent">
				<textarea rows="5" style="width:100%;" class="reply"></textarea>
			</td>
			<td align="center"><button class="btnGoModify btn-custom">수정완료</button></td>
		</tr>
	</table>
</script>
<script id="template_modify2" type="text/x-handlebars-template">
	<span class="content"></span>
</script>
<script type="text/javascript">
	$(function(){
		//목록버튼 눌렀을 때
		$('#btnList').on('click',function(e){
			e.preventDefault();
			location.href='${path}/board/';
		});
		
		//좋아요버튼 눌렀을 때
		$('#btnLike').on('click',function(e){
			e.preventDefault();
			const bnum=${bdto.bnum};
			//alert(bnum);
			
			$.ajax({
				type:'get',
				url:'${path}/board/likeCnt/'+bnum,
				dataType:'json', //map으로 받아야하기 때문
				success:function(result){
					$('#likecnt').html(result.likecnt);
					$('#dislikecnt').html(result.dislikecnt);
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//싫어요버튼 눌렀을 때
		$('#btnDisLike').on('click',function(e){
			e.preventDefault();
			const bnum=${bdto.bnum};
			//alert(bnum);
			
			$.ajax({
				type:'get',
				url:'${path}/board/dislikeCnt/'+bnum,
				dataType:'json', //map으로 받아야하기 때문
				success:function(result){
					$('#likecnt').html(result.likecnt);
					$('#dislikecnt').html(result.dislikecnt);
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//수정버튼 눌렀을 때
		$('#btnModify').on('click',function(e){
			e.preventDefault();
			const bnum=${bdto.bnum};
			//userid체크
			const userid='${sessionScope.userid}';
			const detailUserid='${bdto.userid}';
			console.log(userid);
			location.href='${path}/board/modify/'+bnum;
		});
		
		//삭제버튼 눌렀을 때
		$('#btnDelete').on('click',function(e){
			e.preventDefault();
			const bnum=${bdto.bnum};
			if(confirm('정말 삭제하시겠습니까?')){
				location.href='${path}/board/delete/'+bnum;
			}
		});
		
		/* ------------ 댓글처리 ------------- */
		
		//댓글등록 버튼 눌렀을 때
		$('#btnReplyAdd').on('click',function(){
			const bnum=${bdto.bnum};
			const content=$('#replycontent').val();
			const restep=$('#restep').val();
			const relevel=$('#relevel').val();
			//alert(content);
			if(content==''){
				alert('댓글을 입력해주세요');
				$('#replycontent').focus();
				return ;
			}
			
			$.ajax({
				type:'post',
				contentType:'application/json',
				url:'${path}/reply/',
				data:JSON.stringify({bnum,content,restep,relevel}), //json문자열
				dataType:'text',
				success:function(result){
					alert(result);
					replyList();
					$('#replycontent').val('');
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글의 댓글 버튼 눌렀을 때
		$('#replyList').on('click','.btnReply',function(){
			//alert('댓글');
			const parentsUntil=$(this).parentsUntil('div');
			const replyForm=parentsUntil.find('.replyForm');
			var replyflag=parentsUntil.find('.replyflag').val();
			if(replyflag=='1'){
				replyForm.html('');
				parentsUntil.find('.replyflag').val('0');
				return ;
			}
			var source=$('#template_source2').html();
			var template=Handlebars.compile(source);
			replyForm.html(template());
			
 			const restep=parentsUntil.find('.restep').val();
			const relevel=parentsUntil.find('.relevel').val();
			parentsUntil.find('.replyrestep').val(restep);
			parentsUntil.find('.replyrelevel').val(relevel);
			parentsUntil.find('.replycontent').focus();
			parentsUntil.find('.replyflag').val('1');
		});
		
		//댓글의 댓글 댓글등록 버튼 눌렀을 때
		$('#replyList').on('click','.btnReplyAdd',function(){
			const bnum=${bdto.bnum};
			var parentsUntil=$(this).parentsUntil('div');
			const content=parentsUntil.find('.replycontent').val();
			const restep=parentsUntil.find('.replyrestep').val();
			const relevel=parentsUntil.find('.replyrelevel').val();
			//alert(content+restep+relevel);
 			if(content==''){
				alert('댓글을 입력해주세요');
				parentsUntil.find('.replycontent').focus();
				return ;
			}
			
			$.ajax({
				type:'post',
				contentType:'application/json',
				url:'${path}/reply/',
				data:JSON.stringify({bnum,content,restep,relevel}), //json문자열
				dataType:'text',
				success:function(result){
					alert(result);
					replyList();
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글의 수정 버튼 눌렀을 때
		$('#replyList').on('click','.btnReplyUpdate',function(){
			//alert('댓글');
			const parentsUntil=$(this).parentsUntil('div');
			const userid=parentsUntil.find('.userid').html();
			const sessionuserid='${sessionScope.userid}';
			//console.log(userid);
			//console.log(sessionuserid);
			if(userid!=sessionuserid){
				alert('해당 댓글의 작성자가 아닙니다');
				return ;
			}
			
			const modifyForm=parentsUntil.find('.modifyForm');
			var modifyflag=parentsUntil.find('.modifyflag').val();
			console.log(modifyflag);
			if(modifyflag=='1'){
				const savecontent=parentsUntil.find('.savecontent').val();
				var source=$('#template_modify2').html();
				var template=Handlebars.compile(source);
				modifyForm.html(template());
				const content=parentsUntil.find('.content');
				console.log(savecontent);
				content.html(savecontent);
				parentsUntil.find('.modifyflag').val('0');
				return ;
			}
			const nowcontent=parentsUntil.find('.content').html();
			console.log(nowcontent);
			parentsUntil.find('.nowcontent').val(nowcontent);
			var source=$('#template_modify1').html();
			var template=Handlebars.compile(source);
			modifyForm.html(template());
			const content=parentsUntil.find('.reply');
			content.val(nowcontent);
			parentsUntil.find('.modifyflag').val('1');
			parentsUntil.find('.savecontent').val(nowcontent);
			content.focus();
		});
		
		//댓글 수정의 수정완료 버튼 눌렀을 때
		$('#replyList').on('click','.btnGoModify',function(){
			const parentUntil=$(this).parentsUntil('div');
			const rnum=parentUntil.find('.rnum').val();
			const userid=parentUntil.find('.replyUserid').html();
			const content=parentUntil.find('.reply').val();
			if(content==''){
				alert('댓글을 입력해주세요');
				parentUntil.find('.reply').focus();
				return ;
			}
			console.log(rnum);
			console.log(userid);
			console.log(content);
			
 			$.ajax({
				type:'put', //수정
				contentType:'application/json',
				url:'${path}/reply/',
				data:JSON.stringify({rnum,userid,content}), //json문자열
				dataType:'text',
				success:function(result){
					alert(result);
					replyList();
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글의 삭제 버튼 눌렀을 때
		$('#replyList').on('click','.btnReplyDelete',function(){
			//alert('댓글');
			const userid=$(this).parentsUntil('div').find('.userid').html();
			const sessionuserid='${sessionScope.userid}';
			if(userid!=sessionuserid){
				alert('해당 댓글의 작성자가 아닙니다');
				return ;
			}
			if(!confirm('정말 삭제하시겠습니까?')) return ;
			const rnum=$(this).parentsUntil('div').find('.rnum').val();
			console.log(rnum);
			
			$.ajax({
				type:'delete', //삭제
				url:'${path}/reply/'+rnum,
				dataType:'text',
				success:function(result){
					alert(result);
					replyList();
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글 좋아요버튼 눌렀을 때
		$('#replyList').on('click','.aLike',function(e){
			e.preventDefault();
			const parentUntil=$(this).parentsUntil('div');
			const rnum=parentUntil.find('.rnum').val();
			//alert(rnum);
			
			$.ajax({
				type:'get',
				url:'${path}/reply/likeCnt/'+rnum,
				dataType:'json', //map으로 받아야하기 때문
				success:function(result){
					parentUntil.find('.relikecnt').html(result.likecnt);
					parentUntil.find('.redislikecnt').html(result.dislikecnt);
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글 싫어요버튼 눌렀을 때
		$('#replyList').on('click','.aDisLike',function(e){
			e.preventDefault();
			const parentUntil=$(this).parentsUntil('div');
			const rnum=parentUntil.find('.rnum').val();
			//alert(rnum);
			
			$.ajax({
				type:'get',
				url:'${path}/reply/dislikeCnt/'+rnum,
				dataType:'json', //map으로 받아야하기 때문
				success:function(result){
					parentUntil.find('.relikecnt').html(result.likecnt);
					parentUntil.find('.redislikecnt').html(result.dislikecnt);
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		});
		
		//댓글리스트 조회
		function replyList(){
			const bnum=${bdto.bnum};
			//alert(bnum);
			$.ajax({
				type:'get',
				url:'${path}/reply/'+bnum,
				dataType:'json',
				success:function(result){
					//alert('success');
					console.log(result);
  					Handlebars.registerHelper('level',function(relevel){
						var result='';
						for(i=0;i<relevel;i++){
							result+=".."
						}
						return result;
					});
  					Handlebars.registerHelper('useridCheck',function(userid,options){
						if(userid=='${sessionScope.userid}'){
							return options.fn(this);
						}
					});
					var source=$('#template_replylist').html();
					var template=Handlebars.compile(source);
					$('#replyList').html(template(result));
				},
				error:function(result){
					alert('error');
					console.log(result);
				}
			});
		}
		
		replyList(); //댓글 리스트
	});
</script>
</head>
<body>
<%@include file="../include/menu.jsp" %>
<div class="container">
	<table width="100%">
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<td colspan="2"># ${bdto.bnum}</td>
		</tr>
		<tr>
			<td colspan="2"><h3><b>${bdto.subject}</b></h3></td>
		</tr>
		<tr>
			<td colspan="2"><i class="fas fa-user"></i> ${bdto.userid}&nbsp;&nbsp;<i class="fas fa-eye"></i> ${bdto.readcount}</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				등록일 ${bdto.regdate} | 수정일 ${bdto.modifydate}
				<hr>
			</td>
		</tr>
		<tr>
			<td colspan="2">${bdto.content}</td>
		</tr>
		<c:if test="${!empty bflist}">
			<tr>
				<td colspan="2"><br>파일></td>
			</tr>
			<tr>
				<td colspan="2">
					<c:forEach var="file" items="${bflist}">
						${file.filename}<br>
					</c:forEach>
				</td>
			</tr>
		</c:if>
		<tr>
			<td colspan="2" align="center">
				<br><br>
				<button id="btnLike">좋아요 <span id="likecnt">${bdto.likecnt}</span></button> 
				<button id="btnDisLike"><span id="dislikecnt">${bdto.dislikecnt}</span> 싫어요</button>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<c:if test="${bdto.userid==sessionScope.userid}">
					<button id="btnModify" class="btn-custom">수정</button>
					<button id="btnDelete" class="btn-custom">삭제</button>
				</c:if>
				<button id="btnList" class="btn-custom">목록</button>
				<hr>
			</td>
		</tr>
	</table>
	<table id="tblReply" width="100%">
		<!-- 댓글 -->
		<c:if test="${sessionScope.userid!=null}">
			<tr>
				<td style="width:90%;">
					<input type="hidden" id="restep">
					<input type="hidden" id="relevel"><br>
					<textarea rows="5" style="width:100%;" id="replycontent"></textarea>
				</td>
				<td align="center"><button id="btnReplyAdd" class="btn-custom">댓글등록</button></td>
			</tr>
			<tr>
				<td colspan="2"><br></td>
			</tr>
		</c:if>
		<tr>
			<!-- 댓글의 리스트 -->
			<td id="replyList" colspan="2"></td>
		</tr>
	</table>
</div>
<%@include file="../include/footer.jsp" %>
</body>
</html>