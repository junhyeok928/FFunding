package com.ffunding.web.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ffunding.web.vo.MemberVO;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
	//세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

    //클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        logger.info("{} 연결됨", session.getId()); 
    }

    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        //모든 유저에게 메세지 출력
        for(WebSocketSession sess : sessionList){
            sess.sendMessage(new TextMessage(message.getPayload()));
        }
    }
    //클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getId());
    }


	// 4. 에러발생시 처리 메서드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		logger.info(session.getId() + "에러 발생! 에러내용" + exception.getMessage());
		// session.sendMessage( "에러 발생! 에러내용"+exception.getMessage());
	}

}