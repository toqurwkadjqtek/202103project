package org.project.volleyball.controller;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@ServerEndpoint(value="/onair")
public class OnairSocketController {
	private static final Logger logger = LoggerFactory.getLogger(OnairSocketController.class);
	private static final List<Session> sessionList=new ArrayList<Session>();
	
	public void WebSocketChat() {
        logger.info("웹소켓(서버) 객체생성");
    }

    @OnOpen
    public void onOpen(Session session) throws Exception {
        logger.info("Open session id:"+session.getId());
        //final Basic basic=session.getBasicRemote();
        //basic.sendText("입장하셨습니다");
        sessionList.add(session);
    }
    
    /*
     * 모든 사용자에게 메시지를 전달한다.
     * @param self
     * @param message
     */
    private void sendAllSessionToMessage(Session self,String message) throws Exception {
	    for(Session session : OnairSocketController.sessionList) {
	        if(!self.getId().equals(session.getId())) {
	            //session.getBasicRemote().sendText(message.split(",")[1]+" : "+message);
	        	session.getBasicRemote().sendText(message);
	        }
	    }
    }
    
    @OnMessage
    public void onMessage(String message,Session session) throws Exception {
        //logger.info("Message From "+message.split(",")[1] + ": "+message.split(",")[0]);
    	logger.info(message);
        
        final Basic basic=session.getBasicRemote();
        basic.sendText(message);
        sendAllSessionToMessage(session, message);
    }
    
    @OnError
    public void onError(Throwable e,Session session) {
        
    }
    
    @OnClose
    public void onClose(Session session) {
        logger.info("Session "+session.getId()+" has ended");
        sessionList.remove(session);
    }

}
