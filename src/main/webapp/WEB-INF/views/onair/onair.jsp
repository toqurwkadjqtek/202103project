<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/include.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OnAir</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="template_nogame" type="text/x-handlebars-template">
	<p>지금은 v리그 경기시간이 아닙니다</p>
	<p>OnAir는 경기 1시간 전부터 5시간동안 이용 가능합니다</p>
	<p>예) 경기시간이 19:00 일 경우 18:00 ~ 23:00 운영</p>
	<p>경기 일정을 확인하시려면 <a href='${path}/vleague/schedule'><b>>여기<</b></a>를 클릭해주세요</p>
</script>
<script id="template_yesgame" type="text/x-handlebars-template">
	<p class="text-center">{{vdate}} <img class='slogo' src='${path}/localimg/{{home}}s.png'><b>{{homename}}</b> vs <b>{{awayname}}</b><img class='slogo' src='${path}/localimg/{{away}}s.png'> (중계: {{broad}})</p>
	<div class="text-center">
		<button id="btnHome" class="btn-custom btnSelected" value="home">{{homename}}</button><button id="btnAway" class="btn-custom" value="away">{{awayname}}</button>
		<input type="text" id="sender" value="${sessionScope.userid}" style="display: none;">
		<input type="text" id="messageinput">
		<button id="btnOpen" style="display: none;">Open</button>
		<button id="btnSend" class="btn-custom">입력</button>
		<button id="btnClose" style="display: none;">Close</button>
	</div>
	<hr>
</script>
<script type="text/javascript">
	$(function(){
		var ws;
		let homelogo;
		let awaylogo;
		let date;
		let nowhour;
		let nowmin;
		let nowsec;
		let nowtime;
		let value;
        
        function openSocket(){
            if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
                //writeResponse("WebSocket is already opened.");
                return;
            }
            
            //웹소켓 객체 만드는 코드
            ws=new WebSocket("ws://118.67.132.215:8080/volleyball/onair");
            ws.onopen=function(event){
                //if(event.data===undefined) return;
                writeResponse("환영합니다. 매너 있는 채팅 부탁드립니다.");
            };
            
            ws.onmessage=function(event){
                writeResponseMsg(event.data);
            };
            
            ws.onclose=function(event){
                writeResponse("연결이 종료되었습니다.");
            }
        }
        
        function send(){
        	var text=$('#messageinput').val();
        	if(text==''){
            	alert('내용을 입력해주세요');
            	return ;
            }else if(text.length>'50'){
            	alert('내용은 50자를 넘길 수 없습니다');
            	return ;
            }
        	date=new Date();
        	nowhour=date.getHours()+'';
        	nowmin=date.getMinutes()+'';
        	nowsec=date.getSeconds()+'';
        	if(nowhour.length==1){
        		console.log(nowhour);
        		nowhour='0'+nowhour;
        	}
        	if(nowmin.length==1){
        		nowmin='0'+nowmin;
        	}
        	if(nowsec.length==1){
        		nowsec='0'+nowsec;
        	}
        	nowtime=nowhour+':'+nowmin+':'+nowsec;
        	if(value=='home'){
        		text="<div class='box-padding'><span class='homeBox'><img class='slogo' src='${path}/localimg/"+homelogo+"'> "+text+"</span><span class='nowtime'>"+nowtime+"</span></div>";
        	}else{
        		text="<div class='box-padding box-right'><span class='nowtime'>"+nowtime+"</span><span class='awayBox'><img class='slogo' src='${path}/localimg/"+awaylogo+"'> "+text+"</span></div>";
        	}
            console.log(text);
            
            ws.send(text);
            $('#messageinput').val('');
        }
        
        function closeSocket(){
        	if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
        		ws.close();
            }
        }
        
        function writeResponse(text){
        	var source="<div class='box-padding text-center'><span class=''>"+text+"</span></div>";
            $('#chat').prepend(source);
        }
        
        function writeResponseMsg(text){
        	var source=text;
            $('#chat').prepend(source);
        }
        
        function closeTemplate(){
        	closeSocket();
			var source=$('#template_nogame').html();
			var template=Handlebars.compile(source);
			$('#onairWrapper').html(template());
        }
        
        $('#onairWrapper').on('click','#btnOpen',function(e){
        	e.preventDefault();
        	openSocket();
        });
        
        $('#onairWrapper').on('click','#btnSend',function(e){
        	e.preventDefault();
        	send();
        	$('#messageinput').focus();
        });
        
        $('#onairWrapper').on('click','#btnClose',function(e){
        	e.preventDefault();
        	closeSocket();
        });
        
        $('#onairWrapper').on('click','#btnHome',function(){
 			$(this).css({background:'#008080',color:'#fff'});
 			$('#btnAway').css({background:'#fff',color:'#333'});
 			value=$(this).val();
 			console.log(value);
 			$('#messageinput').focus();
		});
        
        $('#onairWrapper').on('click','#btnAway',function(){
 			$(this).css({background:'#008080',color:'#fff'});
 			$('#btnHome').css({background:'#fff',color:'#333'});
 			value=$(this).val();
 			console.log(value);
 			$('#messageinput').focus();
		});
        
        $('#onairWrapper').on('keydown','#messageinput',function(e){
       		if(e.keyCode==13){
       			send();
       			$('#messageinput').focus();
       		}
        });
        
        function checkToday(){
        	date=new Date();
			let year=date.getFullYear();
			let month=new String(date.getMonth()+1);
			if(month.length==1){
				month='0'+month;
			}
			let day=date.getDate();
			let vdate=year+'-'+month+'-'+day;
			nowhour=date.getHours();
			nowmin=date.getMinutes();
			nowsec=date.getSeconds();
			
			console.log(date.getHours()+":"+date.getMinutes());
			const gubun=${gubun};
			$.ajax({
				type:'get',
				url:'${path}/onair/check',
				data:{vdate,gubun},
				dataType:'json', //돌려받는 데이터 형
				success:function(result){
					homelogo=result.home+'s.png';
					awaylogo=result.away+'s.png';
					const vhour=result.vhour;
					const vmin=result.vmin;
					const hour=vhour-nowhour;
					const min=vmin-nowmin;
  					if(hour>1||hour<-4){
						closeTemplate();
						return ;
					} else if(hour==1&&min>0){
						closeTemplate();
						return ;
					} else if(hour==-4&&min<0){
						closeTemplate();
						return ;
					}
					openSocket();
					var source=$('#template_yesgame').html();
					var template=Handlebars.compile(source);
					$('#onairWrapper').html(template(result));
					value=$('#btnHome').val();
				},
				error:function(result){
					console.log(result);
					closeTemplate();
				}
			});
        }
        
        checkToday()
	});

</script>
</head>
<body>
<%@include file="../include/menu.jsp"%>
<div class="container">
	<div class="maxwidth">
		<h2 class="text-center">OnAir</h2>
		<div id="onairWrapper"></div>
		
		<!-- Server responses get written here -->
		<div id="chat"></div>
	</div>
</div>
<%@include file="../include/footer.jsp"%>
</body>
</html>